#!/bin/zsh

# Copy to clipboard
grim -g "$(slurp)" - | wl-copy

# Just save to file
# grim -g "$(slurp)" &