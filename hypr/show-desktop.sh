#!/usr/bin/env bash
set -euo pipefail

TMP_DIR="${XDG_RUNTIME_DIR:-/tmp}"
STATE_BASE="$TMP_DIR/hypr-show-desktop"

# Current workspace name
WS="$(hyprctl activeworkspace -j | jq -r '.name')"
STATE_FILE="$STATE_BASE-$WS"

if [[ -s "$STATE_FILE" ]]; then
  # Restore: move windows back to the original workspace
  mapfile -t ADDRS < "$STATE_FILE"
  CMDS=""
  for A in "${ADDRS[@]}"; do
    [[ -n "$A" ]] && CMDS+="dispatch movetoworkspacesilent name:$WS,address:$A;"
  done
  [[ -n "$CMDS" ]] && hyprctl --batch "$CMDS"
  rm -f "$STATE_FILE"
else
  # Hide: move all windows from current WS to a special WS named 'desktop'
  ADDRS="$(hyprctl clients -j | jq -r --arg WS "$WS" '.[] | select(.workspace.name==$WS) | .address')"
  [[ -n "$ADDRS" ]] || exit 0
  printf "%s\n" $ADDRS > "$STATE_FILE"
  CMDS=""
  while read -r A; do
    [[ -n "$A" ]] && CMDS+="dispatch movetoworkspacesilent special:desktop,address:$A;"
  done <<< "$ADDRS"
  hyprctl --batch "$CMDS"
fi

