#!/bin/bash

# 讀取 CPU 溫度
if [ -f /sys/class/hwmon/hwmon1/temp1_input ]; then
    cpu=$(cat /sys/class/hwmon/hwmon1/temp1_input)
elif [ -f /sys/class/thermal/thermal_zone0/temp ]; then
    cpu=$(cat /sys/class/thermal/thermal_zone0/temp)
else
    cpu="N/A"
fi

if [ "$cpu" != "N/A" ]; then
    cpu=$(echo "scale=0; $cpu/1000" | bc)
fi

# 讀取 GPU 溫度
gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | head -n1)

# 輸出格式
echo "${cpu}°/${gpu}°"
