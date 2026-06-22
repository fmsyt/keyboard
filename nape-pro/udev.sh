#!/bin/bash

if [ ! -d /etc/udev/rules.d ]; then
  echo "This script is intended for Linux systems with udev support."
  exit 1
fi

VIF=3434
gid=$(id -g)

sudo tee /etc/udev/rules.d/99-nape-pro.rules >/dev/null <<eof
# Direct USB connection
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="$VIF", ATTRS{idProduct}=="0440", MODE="660", GROUP="$gid"

# USB Receiver (Dongle)
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="$VIF", ATTRS{idProduct}=="d026", MODE="660", GROUP="$gid"
eof

sudo udevadm control --reload-rules
sudo udevadm trigger
