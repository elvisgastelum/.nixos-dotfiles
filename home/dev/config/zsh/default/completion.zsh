zcompdump_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$zcompdump_dir" ]] || mkdir -p "$zcompdump_dir"

autoload -Uz compinit
compinit -i -d "$zcompdump_dir/zcompdump"

if command -v dotfiles >/dev/null 2>&1; then
	source <(dotfiles shell-auto-complete --zsh)
fi

if command -v fzf >/dev/null 2>&1 && [[ -t 0 && -t 1 ]]; then
	fzf_files=(/usr/share/fzf/completion.zsh /usr/share/fzf/key-bindings.zsh)

	if [[ -n ${HOMEBREW_PREFIX:-} ]]; then
		fzf_files+=(
			"$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
			"$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
		)
	fi

	for fzf_file in "${fzf_files[@]}"; do
		[[ -r "$fzf_file" ]] && source "$fzf_file"
	done
fi

unset fzf_file fzf_files zcompdump_dir
