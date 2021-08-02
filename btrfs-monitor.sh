#!/bin/sh

# Import config
. /etc/conf.d/btrfs-monitor 2>/dev/null || >&2 echo "Could not source /etc/conf.d/btrfs-monitor"

STATUS_CMD="/bin/btrfs device stats"

send_email() {
	printf "%s\n" \
		"Subject: $1" \
		"MIME-Version: 1.0" \
		"Content-Type: text/html" \
		"Content-Disposition: inline" \
		"<html>" \
		"<body>" \
		"<pre style="font: monospace">" \
		"$(date)" \
		"$2" \
		"</pre>" \
		"</body>" \
		"</html>" \
		| sendmail "$MAILTO"
}

status=$($STATUS_CMD "$1")
if [ $? -ne 0 ]; then
	echo "Error: Can't get device status"
	exit 1
fi

echo "$status" | grep -qE '\s[^0]$'
error_found=$?

message="Status report for $1"
[ $error_found -eq 0 ] && message="Error found on $1"
echo "$message"
echo "$status"

if [ $error_found -eq 0 ] || [ "$ALWAYS_NOTIFY" == "true" ]; then
	if [ -n "$MAILTO" ]; then
		echo "Sending email to $MAILTO"
		send_email "$message" "$status"
	else
		>&2 echo "Error: No email address given"
		exit 1
	fi
fi
