#!/usr/bin/env bash

# This script checks the network connection status and outputs the result.
if ping -q -c 1 -W 1 8.8.8.8 &>/dev/null; then
    interface=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}')

    # cek koneksi menggunakan wifi atau ethernet
    if iw dev | grep -A10 "Interface $interface" | grep -q "type managed"; then
        # koneksi menggunakan Wi-Fi, ambil SSID
        ssid=$(iw dev "$interface" link | grep "SSID" | cut -d ' ' -f2-)

        echo "  Terhubung ke $ssid"
    else
        echo "  Terhubung melalui Ethernet"
    fi
else
    echo "  Disconnected"
fi