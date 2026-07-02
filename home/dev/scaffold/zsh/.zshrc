# Created once by chezmoi; later local edits are preserved.

: "${ZDOTDIR:=${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
: "${ZSH_CONFIG_HOME:=$ZDOTDIR}"

source_safe() {
	[[ -r "$1" ]] && source "$1"
}

source_safe_items() {
	local zsh_config_file

	for zsh_config_file in "$@"; do
		source_safe "$zsh_config_file"
	done
}

source_safe "$ZDOTDIR/default/rc.zsh"

source_safe_items \
	"$ZDOTDIR/env.zsh" \
	"$ZDOTDIR/functions.zsh" \
	"$ZDOTDIR/aliases.zsh" \
	"$ZDOTDIR/plugins.zsh" \
	"$ZDOTDIR/completion.zsh" \
	"$ZDOTDIR/rc.zsh"

unfunction source_safe source_safe_items
