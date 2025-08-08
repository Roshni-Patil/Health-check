#!/bin/sh
source /tmp/ws/config.sh
# Create directory if not exists
sudo mkdir -p /tmp/ws/logs

# Report Visual
{
echo "============================================================"
echo "============================================================"
echo "||                                                        ||"
echo "||                                                        ||"
echo "||          ---- System Health Check ------               ||"
echo "||                                                        ||"
echo "||       logs at $time                      ||"
echo "||                                                        ||"
echo "============================================================"
echo "============================================================"
echo "                                                            "
echo ""
echo "Hostname: $(hostname)"
echo ""
echo ""
echo "--- CPU Load ---"
uptime
echo
echo
echo "--- Memory Usage ---"
free -h
echo
echo
echo "--- Disk Usage ---"
df -h
echo
echo ""
echo "--- Top 5 Memory Consuming Processes ---"
ps aux --sort=%mem | head -n 6
echo
echo
echo "--- Top 5 CPU Consuming Processes ---"
ps aux --sort=%cpu | head -n 6
echo
echo
} > "$logs"
echo""
echo "Report generated at $logs"
echo""