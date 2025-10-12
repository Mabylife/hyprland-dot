#!/bin/bash

# This script parses the output of 'sensors' to get the CPU fan speed
# and formats it for Waybar.

# Run the sensors command and extract the fan speed line.
# This is a basic example, you may need to adjust 'grep' and 'awk' based on your sensors output.
fan_output=$(sensors | grep "cpu_fan:" | awk '{print $2}')"/"$(sensors | grep "gpu_fan:" | awk '{print $2}')

# If fan speed is found, display it.
if [ -n "$fan_output" ]; then
    echo "${fan_output} RPM"
else
    echo "N/A RPM"
fi