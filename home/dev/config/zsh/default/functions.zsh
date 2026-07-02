reload-zsh() {
	source "$ZDOTDIR/.zshrc"
}

kp() {
	if [[ -z "$1" ]]; then
		echo "Usage: kp <port>"
		return 1
	fi

	if [[ "$1" != <-> ]]; then
		echo "Port must be numeric"
		return 1
	fi

	local port
	local -a pids
	port="$1"
	pids=("${(@f)$(lsof -ti :"$port")}")

	if (( ${#pids} == 0 )); then
		echo "No process found on port $port"
		return 1
	fi

	kill -9 -- "${pids[@]}"
	echo "Killed process(es) on port $port: ${pids[*]}"
}

function git_branch_name() {
	git branch --show-current
}

function gpsup() {
	git push --set-upstream origin $(git_branch_name) $@
}

ssh() {
	emulate -L zsh

	local arg target host skip_next=0
	for arg in "$@"; do
		if ((skip_next)); then
			skip_next=0
			continue
		fi

		case "$arg" in
		-b | -c | -D | -E | -e | -F | -I | -i | -J | -L | -l | -m | -O | -o | -p | -Q | -S | -W | -w)
			skip_next=1
			continue
			;;
		--)
			continue
			;;
		-*)
			continue
			;;
		*)
			target="$arg"
			break
			;;
		esac
	done

	host="${target##*@}"
	if [[ -n "$host" && ${WARP_SSH_FISH_HOSTS[(Ie)$host]} -gt 0 ]]; then
		command ssh "$@"
		return $?
	fi

	if typeset -f warp_wrapped_ssh >/dev/null 2>&1; then
		warp_wrapped_ssh "$@"
	else
		command ssh "$@"
	fi
}
