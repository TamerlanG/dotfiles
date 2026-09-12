#!/bin/sh
# Focus the Nth tab (0-indexed) in the current workspace, tmux-window style.
# Bound to prefix+0..9 via [[keys.command]] in config.toml.
# Runs detached from herdr's server env, so no PATH/HERDR_* assumptions.
set -eu

idx=$1
sock=${HERDR_SOCKET_PATH:-$HOME/.config/herdr/herdr.sock}

req() { printf '%s\n' "$1" | /usr/bin/nc -U -w1 "$sock"; }

# tab.list spans all workspaces; `focused` marks the single globally focused tab.
# Pick the tab with 1-indexed `number` in that tab's workspace.
tab=$(req '{"id":"ft","method":"tab.list","params":{"workspace_id":null}}' \
  | /usr/bin/jq -r --argjson n "$((idx + 1))" '
      .result.tabs as $t
      | ($t[] | select(.focused) | .workspace_id) as $ws
      | $t[] | select(.workspace_id == $ws and .number == $n) | .tab_id')

[ -n "$tab" ] || exit 0
req "{\"id\":\"ft\",\"method\":\"tab.focus\",\"params\":{\"tab_id\":\"$tab\"}}" >/dev/null
