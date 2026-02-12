#!/bin/bash

# Define the output file name
REPORT_FILE="system_report.txt"

{
    echo "=========================================="
    echo "          SYSTEM REPORT"
    echo "=========================================="

    # 1. Current date and time
    echo "Date and Time: $(date)"

    # 2. Name of current user
    echo "User: $(whoami)"

    # 3. Internal IP and Hostname
    echo "Hostname: $(hostname)"
    echo "Internal IP: $(hostname -I | awk '{print $1}')"

    # 4. External IP address (Requires internet connection)
    echo "External IP: $(curl -s https://ifconfig.me || echo 'N/A')"

    # 5. Linux Distribution name and version
    echo "OS Distribution: $(lsb_release -d | cut -f2- || cat /etc/os-release | grep "PRETTY_NAME" | cut -d= -f2 | tr -d '\"')"

    # 6. System Uptime
    echo "System Uptime: $(uptime -p)"

    # 7. Disk Space in / (Root) in GB
    echo "Disk Space (/):"
    df -h / | awk 'NR==2 {printf "  Used: %s, Free: %s\n", $3, $4}'

    # 8. RAM Information
    echo "Memory (RAM):"
    free -h | awk 'NR==2 {printf "  Total: %s, Free: %s\n", $2, $4}'

    # 9. CPU Information
    echo "CPU Info:"
    echo "  Cores: $(nproc)"
    echo "  Frequency: $(lscpu | grep "CPU MHz" | awk '{print $3 " MHz"}' || echo 'N/A')"
    
    echo "=========================================="
} > "$REPORT_FILE"

echo "Report generated successfully: $REPORT_FILE"
