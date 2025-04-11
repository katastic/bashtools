#!/bin/sh
# convert all waves current in directory to flac
for i in *.wav; do ffmpeg -i "$i" "${i%.*}.flac" -y; done