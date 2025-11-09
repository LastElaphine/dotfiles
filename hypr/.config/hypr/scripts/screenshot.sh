#!/usr/bin/env bash

# Takes a screenshot using grim + slurp, copies it to clipboard
# also sends a notification with a preview
# Provide a mode to capture region, fullscreen, active monitor, or the active window

save_dir="$HOME/Pictures"
mkdir -p "$save_dir"

filename="screenshot-$(date +%Y%m%d-%H%M%S).png"
filepath="$save_dir/$filename"

mode="${1:-region}" # Defaults to region mode

case "$mode" in
region)
  grim -g "$(slurp)" "$filepath" || exit 1
  ;;
full | fullscreen)
  grim "$filepath" || exit 1
  ;;
output)
  # Capture active window from hyprctl
  output=$(hyprctl activeworkspace -j | jq -r '.monitor')
  grim -o "$output" "$filepath" || exit 1
  ;;
window)
  # Get window geometry in layout coordinates
  read wx wy ww wh < <(echo $(hyprctl activewindow -j | jq -r '.at[0], .at[1], .size[0], .size[1]'))

  # Capture the window region (absolute coordinates)
  grim -g "${wx},${wy} ${ww}x${wh}" "$filepath" || exit 1
  ;;

*)
  echo "Usage: $0 [region|full|window|output]"
  exit 1
  ;;
esac

wl-copy <"$filepath"

notify-send -i "$filepath" "📸 Screenshot" "Saved to $filepath and copied to clipboard."
