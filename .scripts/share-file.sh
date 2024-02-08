#!/usr/bin/env bash
UPLOAD_OUTPUT=$(gdrive files upload --parent "1fOo7n1RtYYo4y5jiljVrrhdgDActhLXG" "$1")
echo "$UPLOAD_OUTPUT"
FILE_ID=$(sed -nr 's/^Id: (.+)$/\1/p' <<< "$UPLOAD_OUTPUT")
FILE_URL=$(sed -nr 's/^ViewUrl: (.+)$/\1/p' <<< "$UPLOAD_OUTPUT")
gdrive permissions share "$FILE_ID"
echo "URL was copied to clipboard!"
pbcopy <<< "$FILE_URL"
