#!/bin/bash

echo "Starting Bluetooth scan..."

# Run bluetooth_scan.sh in the background
nohup ./scan.sh >/dev/null 2>&1 &

echo "Bluetooth scan started."

chmod +x ./blue_hydra/bin/blue_hydra

sudo ./blue_hydra/bin/blue_hydra

