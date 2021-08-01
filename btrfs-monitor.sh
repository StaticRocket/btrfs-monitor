#!/bin/sh

# Import config
. /etc/conf.d/btrfs-monitor 2>/dev/null || >&2 echo "Could not source /etc/conf.d/btrfs-monitor"

STATUS_CMD="/bin/btrfs device stats"

status=$($STATUS_CMD "$1")
status_exit=$?
$status_exit || >&2 echo "Error: Can't get device status" || return $status_exit

if ! echo "$status" | grep -qvE '( 0$)|($)'
then
	echo "Error on $1"
	echo "$status"
	if [ -z "$MAILTO" ]
	then
		printf "%s\n" "Subject: Error on $1" "$status" | sendmail "$MAILTO"
		return 0
	else
		>&2 echo "Error: No email address given"
		return 1
	fi
fi
