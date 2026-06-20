#!/bin/sh

change_by=5
max=100

brightness_float=$(brightnessctl get)
brightness_max=$(brightnessctl max)
brightness_unit=$((brightness_max / 100))

current_brightness=$((brightness_float / brightness_unit))
new_brightness=$((current_brightness + change_by))

if [ "$new_brightness" -gt "$max" ]; then
  brightnessctl set "$max"%
else
  brightnessctl set "$new_brightness"%
fi
