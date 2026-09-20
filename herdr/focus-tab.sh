#!/bin/sh
# Focus the Nth tab (0-indexed) in the current workspace, tmux-window style.
# Bound to prefix+0..9 via [[keys.command]] in config.toml.
# Runs detached from herdr's server env, so no PATH/HERDR_* assumptions.
set -eu

idx=$1
sock=${HERDR_SOCKET_PATH:-$HOME/.config/herdr/herdr.sock}

req() { printf '%s\n' "$1" | /usr/bin/nc -U -w1 "$sock"; }

# tab.list spans all workspaces; `focused` marks the single globally focused tab.
# `number` is a sticky counter (closing a tab leaves gaps: 1,2,6), so index by
# position in the focused tab's workspace, ordered as the tab bar shows them.
tab=$(req '{"id":"ft","method":"tab.list","params":{"workspace_id":null}}' \
  | /usr/bin/jq -r --argjson i "$idx" '
      .result.tabs as $t
      | ($t[] | select(.focused) | .workspace_id) as $ws
      | [$t[] | select(.workspace_id == $ws)] | sort_by(.number) | .[$i].tab_id // empty')

[ -n "$tab" ] || exit 0
req "{\"id\":\"ft\",\"method\":\"tab.focus\",\"params\":{\"tab_id\":\"$tab\"}}" >/dev/null
