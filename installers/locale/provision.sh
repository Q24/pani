#!/bin/bash

echo "Setting system locale"
cp $1/locale.sh /etc/default/locale
locale-gen en_US.UTF-8
timedatectl set-timezone Europe/Amsterdam
echo ""
