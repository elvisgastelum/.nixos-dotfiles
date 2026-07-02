[[ -n ${DOTFILES_ZSH_ENV_LOADED:-} ]] && return
typeset -g DOTFILES_ZSH_ENV_LOADED=1

typeset -gU path PATH

path_prepend() {
	path=("$@" "${path[@]}")
}

path_remove() {
	local path_item

	for path_item in "$@"; do
		path=("${(@)path:#$path_item}")
	done
}

command_exists() {
	(($+commands[$1]))
}

setup_path() {
	path_prepend "$HOME/.local/share/pnpm/bin"
	path_prepend "$HOME/.local/share/gem/ruby/3.4.0/bin" "$HOME/.local/bin"
}

setup_macos_path() {
	[[ $OSTYPE == darwin* ]] || return

	path_prepend \
		"$HOME/.local/bin" \
		/opt/homebrew/bin \
		/opt/homebrew/sbin \
		/usr/local/bin \
		/usr/local/sbin
}

setup_homebrew() {
	command_exists brew || return

	export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"

	[[ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]] &&
		path_prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"

	[[ -x "$HOMEBREW_PREFIX/opt/gcc@12/bin/gcc-12" ]] &&
		export CC="$HOMEBREW_PREFIX/opt/gcc@12/bin/gcc-12"
}

setup_manpage_theme() {
	export BAT_THEME=ansi
	export MANROFFOPT="-c"

	command_exists bat &&
		export MANPAGER="sh -c 'col -bx | bat -l man -p'"
}

setup_editor() {
	[[ -n ${EDITOR:-} ]] &&
		export SUDO_EDITOR="$EDITOR"
}

setup_history() {
	setopt append_history
	setopt extended_history
	setopt hist_ignore_all_dups
	setopt hist_ignore_space
	setopt share_history

	HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
	HISTSIZE=32768
	SAVEHIST="$HISTSIZE"

	[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
}

setup_path
setup_macos_path
setup_homebrew

export PATH

setup_manpage_theme
setup_editor
setup_history

unfunction \
	path_prepend \
	path_remove \
	command_exists \
	setup_path \
	setup_macos_path \
	setup_homebrew \
	setup_manpage_theme \
	setup_editor \
	setup_history
