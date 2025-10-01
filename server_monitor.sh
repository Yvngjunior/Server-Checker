#!/bin/bash

URL="https://glowing-otter-updatedcyberservice.netlify.app/"
LOGFILE="$HOME/site_monitor.log"

while true; do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    # Measure response code & total time
    RESPONSE=$(curl -o /dev/null -s -w "%{http_code} %{time_total}" "$URL")
    STATUS=$(echo $RESPONSE | awk '{print $1}')
    TIME=$(echo $RESPONSE | awk '{print $2}')

    if [ "$STATUS" -eq 200 ]; then
        echo "$TIMESTAMP ✅ $URL is UP | Status: $STATUS | Response Time: ${TIME}s" | tee -a "$LOGFILE"
    else
        echo "$TIMESTAMP ❌ $URL is DOWN | Status: $STATUS | Response Time: ${TIME}s" | tee -a "$LOGFILE"
    fi

    sleep 60
done
