#!/bin/bash

DESKTOP_DIRS=(
    /usr/share/applications
    ~/.local/share/applications
    ~/.local/share/flatpak/exports/share/applications
)

APPS=$(find "${DESKTOP_DIRS[@]}" -name '*.desktop' | \
  xargs -r grep -h '^Name=' | \
  sed 's/^Name=//' | \
  sort -u)

APP=$(echo "$APPS" | dmenu -fn 'monospace-10' -nb '#250000' -nf '#ffffff' -sb '#ff0000' -sf '#ffffff' -l 10 -p "App:")

if [ -n "$APP" ]; then
    FILE=$(find "${DESKTOP_DIRS[@]}" -name '*.desktop' -exec grep -l "Name=$APP" {} + | head -n 1)
    CMD=$(grep '^Exec=' "$FILE" | sed 's/^Exec=//' | cut -d ' ' -f1)
    exec $CMD &
fi
