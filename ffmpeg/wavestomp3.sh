#!/bin/sh
# convert all waves current in directory to nearly lossly mp3. Adjust bitrate down if you care as 320k is considered wasteful compared to FLAC?
for i in *.wav; do ffmpeg -i "$i" -b:a 320k "${i%.*}.mp3" -y; done