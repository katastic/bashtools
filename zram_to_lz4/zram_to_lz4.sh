#!/bin/sh
echo "MUST RUN SUDO."
sudo echo "Thanks."

# --> see man zramctl

# also see http://gionn.net/2012/03/11/zram-on-debian-ubuntu-for-memory-overcommitment/
# https://wiki.gentoo.org/wiki/Zram
# https://www.kernel.org/doc/Documentation/blockdev/zram.txt

# Lets do one full swap change at a time, so the other run can still run as swap while we do it.
# Probably not a big deal, but if it has to flush a lot, maybe it's better.
sudo swapoff /dev/zram0
sudo zramctl -s 468.2M -t 2 -a lz4 /dev/zram0
sudo mkswap /dev/zram0
sudo swapon /dev/zram0

sudo swapoff /dev/zram1
sudo zramctl -s 468.2M -t 2 -a lz4 /dev/zram1
sudo mkswap /dev/zram1
sudo swapon /dev/zram1
