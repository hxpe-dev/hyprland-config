#!/usr/bin/env bash
# Toggle outer gaps between 0 and DESIRED (works with hyprctl JSON output)

DESIRED=20   # change to your preferred gap size

# try to read the "custom" field (like "20 20 20 20")
custom=$(hyprctl getoption general:gaps_out -j 2>/dev/null | jq -r '.custom // ""')

if [ -n "$custom" ]; then
  # take the first number
  current=$(echo "$custom" | awk '{print $1}')
else
  # fallback to parsing human output
  current=$(hyprctl getoption general:gaps_out 2>/dev/null | grep -o -E '[0-9]+' | head -n1 || echo 0)
fi

# ensure numeric
if ! [[ "$current" =~ ^-?[0-9]+$ ]]; then current=0; fi

if [ "$current" -eq 0 ]; then
  hyprctl keyword general:gaps_out "$DESIRED"
else
  hyprctl keyword general:gaps_out 0
fi

