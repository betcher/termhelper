[  -f /etc/termhelper ] && . /etc/termhelper >/dev/null 2>&1
[ -f $HOME/.config/termhelper ] && . $HOME/.config/termhelper >/dev/null  2>&1
if [ ! "$HELLO" -a "$EUID" -ne 0 ] ; then
	termhelper % header
fi

