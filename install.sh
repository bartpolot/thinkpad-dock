#!/bin/sh

sudo install -D udev-rules/*.rules   /etc/udev/rules.d/
sudo install -D src/sys/*.sh         /usr/local/sbin/
install -d                           "$HOME/local/bin/"
install -D src/bin/*.sh              "$HOME/local/bin/"
install -d                           "$HOME/.config/dock/"
install -D src/dock/*                "$HOME/.config/dock/" 
