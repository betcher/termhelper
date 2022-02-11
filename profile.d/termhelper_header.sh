. /etc/termhelper >/dev/null 2>&1
. $HOME/.config/termhelper >/dev/null  2>&1

if [ ! "$HELLO" -a "$(id -u)" -ne 0 ] ; then
	termhelper % header
fi
