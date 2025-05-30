#!/bin/bash

echo "=== Server Performance Stats ==="

# CPU usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User:", $2 "% | System:", $4 "% | Idle:", $8 "%"}'

# Memory usage
echo "Memory Usage:"
free -h | awk 'NR==2{print "Total:", $2, "| Used:", $3, "| Free:", $4}'

# Disk usage
echo "Disk Usage:"
df -h | awk '$NF=="/"{print "Total:", $2, "| Used:", $3, "| Free:", $4, "| Usage:", $5}'

# Network usage (bytes received and transmitted)
echo "Network Usage:"
IFACE=$(ip route | grep default | awk '{print $5}')
RX_BYTES=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
TX_BYTES=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
echo "Interface:", $IFACE, "| Received:", $RX_BYTES, "bytes | Transmitted:", $TX_BYTES, "bytes"

echo "================================"

