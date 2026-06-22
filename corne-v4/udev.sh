#!/bin/bash

if [ ! -d /etc/udev/rules.d ]; then
  echo "This script is intended for Linux systems with udev support."
  exit 1
fi

gid=$(id -g)

sudo tee /etc/udev/rules.d/99-corne-v4.rules >/dev/null <<eof
subsystem=="hidraw", attrs{idvendor}=="4653", attrs{idproduct}=="0004", mode="660", group="$gid"
eof

sudo udevadm control --reload-rules
sudo udevadm trigger
