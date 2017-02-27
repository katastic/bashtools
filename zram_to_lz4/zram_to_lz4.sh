#!/bin/sh
echo "MUST RUN SUDO."
sudo echo "Thanks."

# --> see man zramctl

# higher priorty numbers = HIGHER PRIORITY for swap.

# Hey, should they both be THE SAME PRIORITY (default on my system boot), or is there an advantage to filling one before loading the next?
# I also replicated the 2 streams each, as before.


# also see http://gionn.net/2012/03/11/zram-on-debian-ubuntu-for-memory-overcommitment/
# https://wiki.gentoo.org/wiki/Zram
# https://www.kernel.org/doc/Documentation/blockdev/zram.txt

# cat /sys/block/zram0/comp_algorithm
# lzo [lz4] deflate lz4hc 842

# lzo
# [lz4] means it's selected I think.
# deflate (GZIP?) - better compression but slower
# lz4hc
# 842 - dont use this according to a c file.
# https://catchchallenger.first-world.info/wiki/Quick_Benchmark:_Gzip_vs_Bzip2_vs_LZMA_vs_XZ_vs_LZ4_vs_LZO
# http://stackoverflow.com/questions/28635496/difference-lz77-vs-lz4-vs-lz4hc-compression-algorithms



# https://www.kernel.org/doc/Documentation/blockdev/zram.txt
# https://www.kernel.org/doc/Documentation/block/stat.txt

# SEE ALSO vmstat command (and man vmstat) to see if SWAP is actually being used
# http://askubuntu.com/questions/1357/how-to-empty-swap-if-there-is-free-ram

# Lets do one full swap change at a time, so the other run can still run as swap while we do it.
# Probably not a big deal, but if it has to flush a lot, maybe it's better.
sudo swapoff /dev/zram0
sudo zramctl -s 468.2M -t 2 -a lz4 /dev/zram0
sudo mkswap /dev/zram0
sudo swapon /dev/zram0  -p 10

sudo swapoff /dev/zram1
sudo zramctl -s 468.2M -t 2 -a lz4 /dev/zram1
sudo mkswap /dev/zram1
sudo swapon /dev/zram1 -p 20 

# list results
zramctl
swapon
