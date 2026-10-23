# Nginx Log Analyzer

A Bash-based log analysis tool that analyzes Nginx access logs, counts HTTP status codes, identifies request activity by IP address, and generates a report.

## Features

- Checks whether the log file exists.
- Validates that the log file is not empty.
- Counts total HTTP requests.
- Counts successful requests (`200`).
- Counts not-found responses (`404`).
- Counts server errors (`500`).
- Counts requests by IP address.
- Sorts IP addresses by request count in descending order.
- Generates a timestamped report in `report.txt`.

## Project Structure

```text
nginx-log-analyzer/
├── analyzer.sh
├── README.md
├── report.txt
└── logs/
    └── access.log
```

## Requirements

- Linux or WSL Ubuntu
- Bash
- `awk`
- `sort`
- `wc`
- An Nginx access log file

These utilities are generally available by default on Linux systems.

## Setup

Clone the repository or navigate to the project directory:

```bash
cd nginx-log-analyzer
```

Place your Nginx access log at:

```text
logs/access.log
```

The script expects the standard Nginx combined-style log format, where the client IP is field `$1` and the HTTP status code is field `$9`.

## Usage

Run the analyzer:

```bash
bash analyzer.sh
```

The script displays the analysis in the terminal and saves the report to:

```text
report.txt
```

View the generated report:

```bash
cat report.txt
```

## Example Output

```text
Nginx Log Analyzer
Analyzing file: logs/access.log
Total requests: 5
Successful requests (200): 3
Not Found (404): 1
Server Errors (500): 1

Requests by IP:
192.168.1.10 3
192.168.1.11 1
192.168.1.12 1

Report saved to: report.txt
```

*Example output is based on sample log data.*

## HTTP Status Codes

| Status Code | Meaning |
|---|---|
| 200 | OK — request succeeded |
| 404 | Not Found — requested resource was not found |
| 500 | Internal Server Error — server encountered an unexpected problem |

## Error Handling

The script stops with an error if:

- The specified log file does not exist.
- The log file is empty.

## Concepts Practiced

- Bash scripting and variables
- `if/else` conditions
- File validation using `-f` and `-s`
- Command substitution using `$(...)`
- Log analysis using `awk`
- Sorting output using `sort`
- Counting lines using `wc`
- Saving reports using output redirection
- Generating timestamps using `date`

## Future Improvements

- Support custom log file paths.
- Analyze additional HTTP status codes.
- Identify the most frequently requested URLs.
- Add date-range filtering.
- Support configurable report output locations.

## Disclaimer

This project is intended for learning and practicing Linux, Bash scripting, and log analysis. Use real server logs only when you are authorized to access them.

## Author

Created as a hands-on DevOps and Linux learning project.
