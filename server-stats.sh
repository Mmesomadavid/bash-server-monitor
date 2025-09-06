#!/bin/bash
# server-stats.sh
# A script to analyze server performance stats

# -------- FUNCTIONS --------

get_cpu_usage() {
    echo "=== CPU Usage ==="
    mpstat 1 1 | awk '/Average:/ && $2 ~ /all/ { printf "CPU Usage: %.2f%%\n", 100 - $12 }'
    echo
}

get_memory_usage() {
    echo "=== Memory Usage ==="
    free -h
    echo
}

get_disk_usage() {
    echo "=== Disk Usage ==="
    df -h --total | grep 'total'
    echo
}

get_top_processes_cpu() {
    echo "=== Top 5 Processes by CPU Usage ==="
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
    echo
}

get_top_processes_mem() {
    echo "=== Top 5 Processes by Memory Usage ==="
    ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
    echo
}

get_extra_stats() {
    echo "=== Extra Stats ==="
    echo "OS Version: $(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/*release | head -n 1)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
    echo "Logged in Users: $(who | wc -l)"
    echo
}

# -------- MAIN SCRIPT --------
echo "===== SERVER PERFORMANCE REPORT ====="
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_processes_cpu
get_top_processes_mem
get_extra_stats
echo "===== END OF REPORT ====="
