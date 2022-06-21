#!/bin/sh

change_by=5
min=30

brightness_float=$(light)
brightness=${brightness_float%.*}
new_brightness=`expr $brightness - $change_by`

if [ "$new_brightness" -lt "$min" ]; then
  light -S "$min"
else
  light -U "$change_by"
fi
