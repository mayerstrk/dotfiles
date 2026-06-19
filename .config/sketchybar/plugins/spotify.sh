#!/bin/bash

CACHE_DIR="/tmp/sketchybar"
TRACK_CACHE="$CACHE_DIR/current_track"

# Check if Spotify is running and get state
if ! pgrep -x "Spotify" >/dev/null; then
	STATE=""
else
	STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
fi

# Hide if not playing or paused
if [ "$STATE" != "playing" ] && [ "$STATE" != "paused" ]; then
	sketchybar --set spotify.text drawing=off \
		--set spotify.cover drawing=off
	rm -f "$TRACK_CACHE"
	exit 0
fi

# Get track info
TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
COVER_URL=$(osascript -e 'tell application "Spotify" to artwork url of current track' 2>/dev/null)

# Build label and set font style based on state
LABEL="$ARTIST - $TRACK"
if [ "$STATE" = "playing" ]; then
	FONT_STYLE="BlexMono Nerd Font:Italic:15.5"
else
	FONT_STYLE="BlexMono Nerd Font:Regular:15.5"
fi

# Download or retrieve cached cover image
mkdir -p "$CACHE_DIR"
COVER_DRAWING="off"
COVER_IMAGE=""
if [ -n "$COVER_URL" ]; then
	# Create a cache filename based on URL hash
	COVER_HASH=$(echo -n "$COVER_URL" | md5)
	COVER_PATH="$CACHE_DIR/cover_${COVER_HASH}.jpg"

	# Use cached version if it exists, otherwise download
	if [ -f "$COVER_PATH" ]; then
		COVER_DRAWING="on"
		COVER_IMAGE="$COVER_PATH"
	elif curl -s --max-time 5 "$COVER_URL" -o "$COVER_PATH"; then
		COVER_DRAWING="on"
		COVER_IMAGE="$COVER_PATH"
	fi
fi

# Detect track change and animate
PREVIOUS_TRACK=""
if [ -f "$TRACK_CACHE" ]; then
	PREVIOUS_TRACK=$(cat "$TRACK_CACHE")
fi

if [ "$LABEL" != "$PREVIOUS_TRACK" ] && [ -n "$PREVIOUS_TRACK" ]; then
	# Track changed - animate the label change
	sketchybar --animate tanh 8 \
		--set spotify.text label="$LABEL" \
		label.font="$FONT_STYLE"
else
	# No change or first run - just update
	sketchybar --set spotify.text \
		label="$LABEL" \
		label.font="$FONT_STYLE"
fi

# Save current track
echo "$LABEL" >"$TRACK_CACHE"

# Update cover and visibility
sketchybar --set spotify.text drawing=on \
	--set spotify.cover \
	background.image="$COVER_IMAGE" \
	drawing="$COVER_DRAWING"
