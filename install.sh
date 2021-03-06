#!/bin/sh

sudo install -D udev-rules/*.rules   /etc/udev/rules.d/     -m 640
sudo install -D src/sys/*.sh         /usr/local/sbin/
install -d                           "$HOME/.config/dock/"
install -D src/dock/*                "$HOME/.config/dock/" 
install -d                           "$HOME/local/bin/"
install -D src/bin/*                 "$HOME/local/bin/"
