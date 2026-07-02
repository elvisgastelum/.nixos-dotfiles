#!/usr/bin/env bash
set -euo pipefail

if pgrep -f '^gpu-screen-recorder' >/dev/null; then
	printf '{"text":"󰻂","tooltip":"Stop recording","class":"active"}\n'
else
	printf '{"text":""}\n'
fi
