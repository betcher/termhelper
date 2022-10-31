#!/bin/bash
# This script measures how long it takes to load metadata by dnf.
# Put this file into /etc/anaconda-scripts.d/post-install/,
# ROSA-specific Anaconda script runs all those scripts in chroot of the just installed system.
# Dependencies: bash, time, dnf

set -e
set -o pipefail
set -u

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
