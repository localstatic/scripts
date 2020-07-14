#!/bin/bash

GARDEN_PATH="${HOME}/garden"

rsync -avr pi@garden:/home/pi/camera-images/ "${GARDEN_PATH}/images"

ffmpeg -y -r 30 -pattern_type glob -i "${GARDEN_PATH}/images/*:[03]0:??-06:00.jpg" -s hd1080 -vcodec libx264 "${GARDEN_PATH}/timelapse-fast.mp4"
ffmpeg -y -r 15 -pattern_type glob -i "${GARDEN_PATH}/images/*.jpg" -s hd1080 -vcodec libx264 "${GARDEN_PATH}/timelapse.mp4"
