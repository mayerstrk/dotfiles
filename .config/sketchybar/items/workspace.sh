#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

workspace=(
  label="?"
  icon.drawing=off
  padding_left=4
  padding_right=4
  label.width=28
  label.align=center
  label.font="BlexMono Nerd Font:Regular:16.0" # ← bigger for visibility
  script="$PLUGIN_DIR/workspace.sh"
  update_freq=5 # ← optional fallback polling (every 5s)
)

sketchybar --add item workspace left \
  --set workspace "${workspace[@]}" \
  --subscribe workspace aerospace_workspace_change
