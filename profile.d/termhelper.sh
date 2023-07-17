#!/bin/sh
command_not_found_handle() {
    #BINARYSEARCH='no'
    . termhelper-functions || { echo "termhelper-functions not found!" && return 1 ;}
    MSG01="$(_th_gettext -s "command not found")"
    MSG02="$(_th_gettext -s "try to install one of this")"
    MSG03="$(_th_gettext -s "Warning:")"
    MSG04="$(_th_gettext -s "the file was found in the directory for the root  binaries")"
    MSG05="$(_th_gettext -s "you need root permissions (sudo, su -), or try to execute it with full path")"
    MSG06="$(_th_gettext -s "Did you mean")"

    _translit() {
	echo "$@" | sed -e 'y/йцукенгшщзхъ/qwertyuiop[]/' \
				    -e "y/фывапролджэ/asdfghjkl;'/" \
				    -e "y#ячсмитьбю.#zxcvbnm,./#" \
				    -e 'y/ЙЦУКЕНГШЩЗХЪ/QWERTYUIOP{}/' \
				    -e 'y/ФЫВАПРОЛДЖЭ/ASDFGHJKL:"/' \
				    -e 'y/ЯЧСМИТЬБЮ,/ZXCVBNM<>?/' \
				    -e 'y/№\:\?/#^&/'
    }
    echo "$0: $MSG01: $1" >&2
    if [ -t 1 ]; then
		_th_load_config
		[ "${BINARYSEARCH}_" = 'no_' ] && return 127
		if [[ "$1:0:1" = *[![:ascii:]]* ]] ; then
		    cmd=$(_translit $1)
		    shift
		    args=$(_translit "$@")
		    [ "$1" != "$cmd" ] && echo -e "${MSG06}: ${magenta}${cmd} ${args}$default"
		    return 127
		fi

		case "$PATH" in
		*/sbin* ) : ;;
		* )
			found=$(find /sbin /usr/sbin -type f -executable -name "$1")
			if [ "$found" ] ; then
				# variable is not add, w/a line breaks
				text="$(printf "\"%s\" - %s,\n%s:\n - %s" "${1}" "${MSG04}" "${MSG05}" "${found}")"
				echo "$text" | termhelper - "${MSG03}:"
				return 127
			fi
		;;
		esac
		[[ ${1:(-1):1} == [[:alnum:]] ]] && test -x /usr/bin/dnf && \
		PACKS="$(/usr/bin/dnf repoquery -qC --qf "sudo dnf install %{name}" /usr/bin/$1 /usr/sbin/$1 /bin/$1 /sbin/$1 2>/dev/null)"
		[ -n "$PACKS" ] &&   echo "$PACKS" | termhelper - "${MSG02}:"
	fi
    return 127
}
alias справка=termhelper
alias aiuto=termhelper
