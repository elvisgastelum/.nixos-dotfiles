# Machine-local zprofile.
# Created once by chezmoi; later local edits are preserved.

if [[ $OSTYPE == darwin* && -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi
