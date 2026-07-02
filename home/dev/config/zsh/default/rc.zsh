# Managed zsh defaults. Local files are loaded by ~/.config/zsh/.zshrc.

source_safe_items \
	"$ZDOTDIR/default/env.zsh" \
	"$ZDOTDIR/default/functions.zsh" \
	"$ZDOTDIR/default/aliases.zsh" \
	"$ZDOTDIR/default/plugins.zsh" \
	"$ZDOTDIR/default/completion.zsh"
