#!/bin/bash
sleep 8
while true
do
    echo "Scanning for nearby Bluetooth devices..."
    bluetoothctl agent on> /dev/null 2>&1
    bluetoothctl scan on> /dev/null 2>&1
    sleep 40
done
