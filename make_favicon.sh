#!/bin/bash
# Usage: ./make_favicon.sh <input_image>
# Outputs: favicon_resize.png (144x144) and favicon_circle.png (144x144, circular mask)

INPUT="${1:-favicon.png}"
RESIZE="favicon_resize.png"
CIRCLE="favicon_circle.png"

ffmpeg -y -i "$INPUT" -vf scale=144:144 -frames:v 1 "$RESIZE"
ffmpeg -y -i "$RESIZE" -vf "format=argb,geq=r='r(X,Y)':g='g(X,Y)':b='b(X,Y)':a='if(lte((X-72)^2+(Y-72)^2,72*72),255,0)'" -frames:v 1 "$CIRCLE"

echo "Done: $RESIZE and $CIRCLE"
