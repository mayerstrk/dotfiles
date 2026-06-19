#!/bin/bash

front_app=(
	icon.drawing=off
	script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
