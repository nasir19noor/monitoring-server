* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

header {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    margin-bottom: 30px;
    text-align: center;
}

header h1 {
    color: #333;
    font-size: 2.5em;
    margin-bottom: 10px;
}

#last-update {
    color: #666;
    font-size: 0.9em;
}

#timestamp {
    font-weight: bold;
    color: #667eea;
}

.system-info {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 15px;
    margin-bottom: 30px;
}

.info-card {
    background: white;
    padding: 15px 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.info-card .label {
    font-weight: 600;
    color: #666;
}

.info-card .value {
    color: #333;
    font-weight: bold;
}

.metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-bottom: 30px;
}

.metric-card {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s ease;
}

.metric-card:hover {
    transform: translateY(-5px);
}

.metric-card h2 {
    color: #333;
    font-size: 1.2em;
    margin-bottom: 20px;
    text-align: center;
}

.metric-value {
    text-align: center;
    margin-bottom: 20px;
}

.value-large {
    font-size: 3em;
    font-weight: bold;
    color: #667eea;
}

.unit {
    font-size: 1.5em;
    color: #999;
    margin-left: 5px;
}

.progress-bar {
    height: 20px;
    background: #e0e0e0;
    border-radius: 10px;
    overflow: hidden;
    margin-bottom: 15px;
}

.progress-fill {
    height: 100%;
    transition: width 0.5s ease, background-color 0.5s ease;
    border-radius: 10px;
}

.progress-fill.low {
    background: linear-gradient(90deg, #11998e 0%, #38ef7d 100%);
}

.progress-fill.medium {
    background: linear-gradient(90deg, #f2994a 0%, #f2c94c 100%);
}

.progress-fill.high {
    background: linear-gradient(90deg, #eb3349 0%, #f45c43 100%);
}

.metric-info {
    text-align: center;
    color: #666;
    font-size: 0.9em;
}

.network-stats {
    padding: 20px 0;
}

.network-item {
    display: flex;
    justify-content: space-between;
    padding: 15px 0;
    border-bottom: 1px solid #eee;
}

.network-item:last-child {
    border-bottom: none;
}

.network-label {
    font-weight: 600;
    color: #666;
    font-size: 1.1em;
}

.network-value {
    font-weight: bold;
    color: #667eea;
    font-size: 1.1em;
}

.status-indicator {
    background: white;
    padding: 15px 25px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.status-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: #ccc;
    animation: pulse 2s infinite;
}

.status-dot.active {
    background: #38ef7d;
}

.status-dot.error {
    background: #eb3349;
}

#status-text {
    font-weight: 600;
    color: #333;
}

@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
}

@media (max-width: 768px) {
    header h1 {
        font-size: 1.8em;
    }

    .metrics-grid {
        grid-template-columns: 1fr;
    }

    .value-large {
        font-size: 2.5em;
    }
}