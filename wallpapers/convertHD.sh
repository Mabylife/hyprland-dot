#!/bin/bash
for img in *.jpg *.png; do
  convert "$img" -resize 1920x1080! "converted_${img}"
done
