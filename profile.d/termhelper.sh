command_not_found_handle() {
	export TEXTDOMAIN="termhelper"
	TEXTDOMAINDIR="/usr/share/locale"
	MSG01="$(gettext -s "command not found")"
    MSG02="$(gettext -s "try to install one of this")"
    MSG03="$(gettext -s "Warning:")"
    MSG04="$(gettext -s "avaliable for root only")"
    
    echo "$0: $MSG01: $1" >&2
    if [[ -t 1 ]] ; then
		if ! echo $PATH |grep -q '/sbin' ; then
			if find /sbin /usr/sbin -type f -executable -name "$1" |grep -q . ; then
				echo "${1}: $MSG04" | termhelper - "${MSG03}:"
				return 127
			fi
		fi
		[ -f /usr/bin/dnf ] && 	PACKS=$(dnf repoquery -qC --qf "dnf install %{name}" /usr/bin/$1 /usr/sbin/$1 /bin/$1 /sbin/$1 2>/dev/null) 
		[ -n "$PACKS" ] &&   echo "$PACKS" | termhelper - "${MSG02}:"
	fi
    return 127
} 
