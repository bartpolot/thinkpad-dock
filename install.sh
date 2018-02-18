#!/bin/sh

sudo install -D udev-rules/*.rules   /etc/udev/rules.d/
sudo install -D src/sys/*.sh         /usr/local/sbin/
install -D src/bin/*.sh              ~/local/bin/
install -D src/dock/*                "$HOME/.config/dock/" 
