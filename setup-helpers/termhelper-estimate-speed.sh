#!/bin/bash
# This scripts tries to gues:
# will dnf load metadata quickly enough
# so that handling a not found command
# would take not too much time?

set -e
set -u
set -o pipefail

f=/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
if ! test -f "$f"; then
	echo "File $f does not exist" >&2
	exit 1
fi
# example content of $f: 3100000 (3.1 GHz)
# -lt means <
if [ "$(<"$f")" -lt 2000001 ]; then
	mkdir -p /run/termhelper.d/
	file=/run/termhelper.d/01-nobinsearch.conf
	echo '# disable finding which package contains a not found command' > "$file"
	echo '# because this computer is rather slow' >> "$file"
	echo 'BINARYSEARCH=no' >> "$file"
fi
