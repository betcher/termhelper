#!/bin/bash
# This script measures how long it takes to load metadata by dnf.
# Put this file into /etc/anaconda-scripts.d/post-install/,
# ROSA-specific Anaconda script runs all those scripts in chroot of the just installed system.
# Dependencies: bash, time, dnf

set -e
set -o pipefail
set -u

# if dnf metadata has not been downloaded...
# (90-rosa1-postinstall.sh of Anaconda downloads it before running this script)
dnf_has_metadata=0
for i in /var/cache/dnf/*.solv
do
	if test -e "$i"; then
		dnf_has_metadata=1
		break
	fi
done
# no sense to run "dnf shell" if there is no internet connection
# (its metadata would have already been downloaded otherwise),
# fallback to estimation by CPU frequency
if [ "$dnf_has_metadata" = 0 ]; then
	exec termhelper-estimate-speed
fi

# /usr/bin/time (GNU time) is not bash built-in time
time="$(TIME='%e' /usr/bin/time sh -c 'echo exit | dnf shell --setopt=metadata_expire=-1 >/dev/null 2>&1' 2>&1)"
# 1.40 -> 1
IFS=. read -r -a arr <<< "$time"
time="${arr[0]}"
# check that it is a valid number
if ! [ "$time" -ge 0 ]; then
	echo "Error measuring time" >&2
	exit 1
fi
echo "$time" >&2
# -gt means "greater than" (>)
# if loading dnf metadata takes > 3.99 sec
if [ "$time" -gt 3 ]; then
	mkdir -p /etc/termhelper.d/
	file=/etc/termhelper.d/01-nobinsearch.conf
	echo '# disable finding which package contains a not found command' > "$file"
	echo '# because this computer is rather slow' >> "$file"
	echo 'BINARYSEARCH=no' >> "$file"
	echo "This machine is probably too slow for running dnf repoquery search when command is not found" 2>&1
fi
