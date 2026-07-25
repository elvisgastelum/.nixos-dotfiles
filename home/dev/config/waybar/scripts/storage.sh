#!/usr/bin/env bash
set -euo pipefail

mapfile -t df_lines < <(LC_ALL=C df -h --output=used,size,avail,pcent,target /)
read -r used total free pcent path <<<"${df_lines[1]}"
percent=${pcent%%%}

python3 - "$used" "$total" "$free" "$percent" "$path" <<'PY'
import json
import sys

used, total, free, percent, path = sys.argv[1:]
print(json.dumps({
    "text": f" {used}/{total}",
    "tooltip": f"{used} used out of {total} on {path}\n{free} free ({percent}%)",
    "percentage": int(percent),
}, ensure_ascii=False, separators=(",", ":")))
PY
