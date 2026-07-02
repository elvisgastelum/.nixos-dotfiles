#!/usr/bin/env bash

set -euo pipefail

pid_file="${XDG_RUNTIME_DIR:-/tmp}/no-sleep.pid"

is_inhibiting() {
  [[ -f "$pid_file" ]] && kill -0 "$(<"$pid_file")" 2>/dev/null
}

refresh_waybar() {
  pkill -RTMIN+9 waybar 2>/dev/null || true
}

enable_no_sleep() {
  pkill -x hypridle 2>/dev/null || true

  if ! is_inhibiting; then
    systemd-inhibit \
      --what=sleep:idle \
      --who="No Sleep" \
      --why="No Sleep mode enabled from Waybar" \
      --mode=block \
      sleep infinity &
    printf '%s\n' "$!" >"$pid_file"
  fi

  notify-send -u low "󱫖    No Sleep enabled"
  refresh_waybar
}

disable_no_sleep() {
  if is_inhibiting; then
    kill "$(<"$pid_file")" 2>/dev/null || true
  fi

  rm -f "$pid_file"

  if ! pgrep -x hypridle >/dev/null; then
    uwsm-app -- hypridle >/dev/null 2>&1 &
  fi

  notify-send -u low "󰒲    No Sleep disabled"
  refresh_waybar
}

status() {
  if is_inhibiting || ! pgrep -x hypridle >/dev/null; then
    printf '{"text":"󱫖","tooltip":"No Sleep enabled: idle lock and system suspend are blocked","class":"active"}\n'
  else
    printf '{"text":"󰒲","tooltip":"No Sleep disabled: idle lock and system suspend are allowed"}\n'
  fi
}

case "${1:-status}" in
  enable)
    enable_no_sleep
    ;;
  disable)
    disable_no_sleep
    ;;
  toggle)
    if is_inhibiting || ! pgrep -x hypridle >/dev/null; then
      disable_no_sleep
    else
      enable_no_sleep
    fi
    ;;
  status)
    status
    ;;
  *)
    printf 'Usage: %s [enable|disable|toggle|status]\n' "$0" >&2
    exit 2
    ;;
esac
