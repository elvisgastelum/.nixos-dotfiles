# Zap plugin manager bootstrap and plugin declarations.
# This is the single managed place that bootstraps Zap before any `plug` calls.

export ZAP_DIR="${ZAP_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/zap}"

# Bootstrap Zap if not already present.
if [[ ! -f "$ZAP_DIR/zap.zsh" ]]; then
  if (($+commands[git])); then
    mkdir -p "$ZAP_DIR" &&
      git clone --branch release-v1 https://github.com/zap-zsh/zap.git "$ZAP_DIR" ||
      printf '%s\n' "Warning: Zap clone failed; zsh plugins may be unavailable." >&2
  else
    printf '%s\n' "Warning: git not found; cannot bootstrap Zap. Install git and restart zsh." >&2
  fi
fi

# Source Zap if available and declare plugins.
if [[ -r "$ZAP_DIR/zap.zsh" ]]; then
  source "$ZAP_DIR/zap.zsh"

  if (($+functions[plug])); then
    plug "zap-zsh/supercharge"
    plug "zap-zsh/fzf"

    plug "zsh-users/zsh-autosuggestions"
    plug "zsh-users/zsh-syntax-highlighting"
    plug "zsh-users/zsh-history-substring-search"

    plug "MAHcodes/distro-prompt"
    plug "MichaelAquilina/zsh-you-should-use"
    plug "Aloxaf/fzf-tab"
    plug "wintermi/zsh-bob"

    plug "elvisgastelum/zoxide-zsh"

    # plug local plugins
    plug "$HOME/.config/zsh/default/plugins/*"
  else
    printf '%s\n' "Warning: Zap sourced but plug function not available; plugins not loaded." >&2
  fi
else
  printf '%s\n' "Warning: Zap not installed; zsh plugins are disabled." >&2
fi
