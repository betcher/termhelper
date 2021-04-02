command_not_found_handle() {
	export TEXTDOMAIN="termhelper"
	TEXTDOMAINDIR="/usr/share/locale"
	MSG01="$(gettext -s "command not found")"
    MSG02="$(gettext -s "try to install one of this")"
    echo "$(basename $0): $MSG01: $1" >&2
    if [[ -t 1 ]] ; then
		# urpmf works like a peice of shit, uncomment this string if you know how to fix it. 
		#[ -f /usr/bin/urpmf ] && PACKS="$(urpmf --uniq --qf 'urpmi %-30name #found' --files /usr/bin/"$1" /bin/"$1" /sbin/"$1" 2>/dev/null)" 
		[ -f /usr/bin/dnf ] && 	PACKS=$(dnf repoquery -qC --qf "dnf install %{name}" /usr/bin/$1 /bin/$1 /sbin/$1 2>/dev/null) 
		[ -n "$PACKS" ] &&   echo "$PACKS" | termhelper - "${MSG02}:"
    fi
    return 127
} 
