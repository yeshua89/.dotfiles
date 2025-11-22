#!/bin/bash
# Script compacto para verificar estado de VPN

vpn_active=false
vpn_name=""

# Verificar ProtonVPN / WireGuard por NetworkManager
if command -v nmcli &> /dev/null; then
    vpn_conn=$(nmcli -t -f NAME,TYPE connection show --active | grep wireguard)
    if [ -n "$vpn_conn" ]; then
        vpn_active=true
        vpn_name=$(echo "$vpn_conn" | cut -d: -f1)
    fi

    # Verificar otros tipos de VPN
    if [ "$vpn_active" = false ]; then
        vpn_conn=$(nmcli -t -f NAME,TYPE connection show --active | grep vpn)
        if [ -n "$vpn_conn" ]; then
            vpn_active=true
            vpn_name=$(echo "$vpn_conn" | cut -d: -f1)
        fi
    fi
fi

# Verificar WireGuard directo
if [ "$vpn_active" = false ] && command -v wg &> /dev/null; then
    wg_interfaces=$(wg show interfaces 2>/dev/null)
    if [ -n "$wg_interfaces" ]; then
        vpn_active=true
        vpn_name="WireGuard: $wg_interfaces"
    fi
fi

# Verificar OpenVPN
if [ "$vpn_active" = false ] && pgrep -x openvpn &> /dev/null; then
    vpn_active=true
    vpn_name="OpenVPN"
fi

# Output JSON
if [ "$vpn_active" = true ]; then
    echo '{"text":"󰖂","tooltip":"'"$vpn_name"'","class":"connected"}'
else
    echo '{"text":"󰿆","tooltip":"VPN desconectada","class":"disconnected"}'
fi
