#!/bin/bash
# workspace.sh

NAME="${NAME:-workspace}"

# Optional: log for debugging (remove later if you want)
# echo "$(date '+%H:%M:%S') $NAME called | FOCUSED=$FOCUSED_WORKSPACE" >> /tmp/sketchybar-workspace.log

focused="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"

if [[ -z "$focused" ]]; then
  sketchybar --set "$NAME" label="?"
  exit 0
fi

sketchybar --set "$NAME" label="$focused"
