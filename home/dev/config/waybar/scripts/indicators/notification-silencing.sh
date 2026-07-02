#!/usr/bin/env bash
set -euo pipefail

if makoctl mode | grep -q 'do-not-disturb'; then
	printf '{"text":"󰂛","tooltip":"Notifications silenced","class":"active"}\n'
else
	printf '{"text":""}\n'
fi
