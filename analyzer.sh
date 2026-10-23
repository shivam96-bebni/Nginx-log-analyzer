
#!/bin/bash

echo "Nginx Log Analyzer"

log_file="logs/access.log"
report_file="report.txt"

# Check if log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file not found!"
    exit 1
fi

# Check if log file is not empty
if [ ! -s "$log_file" ]; then
    echo "Error: Log file is empty!"
    exit 1
fi

echo "Analyzing file: $log_file"

# Count total requests
total_request=$(wc -l < "$log_file")

# Count HTTP status codes
success_count=$(awk '$9 == "200" {count++} END {print count+0}' "$log_file")
not_found_count=$(awk '$9 == "404" {count++} END {print count+0}' "$log_file")
server_error_count=$(awk '$9 == "500" {count++} END {print count+0}' "$log_file")

# Count requests by IP and sort by highest count
ip_report=$(awk '{count[$1]++} END {for (ip in count) print ip, count[ip]}' "$log_file" | sort -k2,2nr)

# Display report in terminal
echo "Total requests: $total_request"
echo "Successful requests (200): $success_count"
echo "Not Found (404): $not_found_count"
echo "Server Errors (500): $server_error_count"
echo
echo "Requests by IP:"
echo "$ip_report"

# Save a fresh report with timestamp
{
    echo "Nginx Log Analyzer Report"
    echo "Generated: $(date '+%F %T')"
    echo "Analyzed file: $log_file"
    echo "Total requests: $total_request"
    echo "Successful requests (200): $success_count"
    echo "Not Found (404): $not_found_count"
    echo "Server Errors (500): $server_error_count"
    echo
    echo "Requests by IP:"
    echo "$ip_report"
} > "$report_file"

echo
echo "Report saved to: $report_file"
