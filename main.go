package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"runtime"
	"time"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/disk"
	"github.com/shirou/gopsutil/v3/host"
	"github.com/shirou/gopsutil/v3/mem"
	"github.com/shirou/gopsutil/v3/net"
)

type SystemMetrics struct {
	Timestamp     time.Time       `json:"timestamp"`
	Hostname      string          `json:"hostname"`
	Uptime        uint64          `json:"uptime"`
	OS            string          `json:"os"`
	Platform      string          `json:"platform"`
	CPUPercent    float64         `json:"cpu_percent"`
	CPUCores      int             `json:"cpu_cores"`
	MemoryTotal   uint64          `json:"memory_total"`
	MemoryUsed    uint64          `json:"memory_used"`
	MemoryPercent float64         `json:"memory_percent"`
	DiskTotal     uint64          `json:"disk_total"`
	DiskUsed      uint64          `json:"disk_used"`
	DiskPercent   float64         `json:"disk_percent"`
	NetworkSent   uint64          `json:"network_sent"`
	NetworkRecv   uint64          `json:"network_recv"`
}

var lastNetStats net.IOCountersStat

func getSystemMetrics() (*SystemMetrics, error) {
	metrics := &SystemMetrics{
		Timestamp: time.Now(),
		CPUCores:  runtime.NumCPU(),
	}

	// Host info
	hostInfo, err := host.Info()
	if err != nil {
		return nil, err
	}
	metrics.Hostname = hostInfo.Hostname
	metrics.Uptime = hostInfo.Uptime
	metrics.OS = hostInfo.OS
	metrics.Platform = hostInfo.Platform

	// CPU usage
	cpuPercent, err := cpu.Percent(time.Second, false)
	if err != nil {
		return nil, err
	}
	if len(cpuPercent) > 0 {
		metrics.CPUPercent = cpuPercent[0]
	}

	// Memory usage
	memInfo, err := mem.VirtualMemory()
	if err != nil {
		return nil, err
	}
	metrics.MemoryTotal = memInfo.Total
	metrics.MemoryUsed = memInfo.Used
	metrics.MemoryPercent = memInfo.UsedPercent

	// Disk usage
	diskInfo, err := disk.Usage("/")
	if err != nil {
		return nil, err
	}
	metrics.DiskTotal = diskInfo.Total
	metrics.DiskUsed = diskInfo.Used
	metrics.DiskPercent = diskInfo.UsedPercent

	// Network stats
	netStats, err := net.IOCounters(false)
	if err == nil && len(netStats) > 0 {
		metrics.NetworkSent = netStats[0].BytesSent
		metrics.NetworkRecv = netStats[0].BytesRecv
	}

	return metrics, nil
}

func metricsHandler(w http.ResponseWriter, r *http.Request) {
	metrics, err := getSystemMetrics()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(metrics)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/index.html"))
	tmpl.Execute(w, nil)
}

func main() {
	// Serve static files
	fs := http.FileServer(http.Dir("static"))
	http.Handle("/static/", http.StripPrefix("/static/", fs))

	// API endpoint
	http.HandleFunc("/api/metrics", metricsHandler)

	// Web UI
	http.HandleFunc("/", indexHandler)

	port := ":8080"
	fmt.Printf("Server monitoring tool started on http://localhost%s\n", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
