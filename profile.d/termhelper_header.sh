[  -f /etc/termhelper ] && . /etc/termhelper >/dev/null 2>&1
[ -f $HOME/.config/termhelper ] && . $HOME/.config/termhelper >/dev/null  2>&1
if [ ! "$HELLO" -a "$(id -u)" -ne 0 ] ; then
	termhelper % header
fi

