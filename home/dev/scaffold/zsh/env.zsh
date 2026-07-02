# Machine-local zsh environment.
# Created once by chezmoi; later local edits are preserved.

# Safely load KEY=VALUE secrets from $ZDOTDIR/.env (create-only, never overwritten).
# Only lines matching KEY=VALUE are exported; arbitrary shell code is NOT executed.
# Values may contain spaces or special characters; quotes are preserved as-is.
if [[ -r "$ZDOTDIR/.env" ]]; then
  while IFS= read -r line; do
    # Skip comments and blank lines
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$line" ]] && continue
    # Split on first '=' only (handles values with embedded '=')
    key="${line%%=*}"
    value="${line#*=}"
    # Only export valid shell variable names
    if [[ "$key" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
      export "$key=$value"
    fi
  done < "$ZDOTDIR/.env"
fi
