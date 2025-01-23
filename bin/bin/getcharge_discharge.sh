#!/bin/bash

charge=$(cat /sys/class/power_supply/BAT1/current_now)
echo "$charge / 1000" | bc
