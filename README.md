# btrfs-monitor
Like mdmonitor but for btrfs filesystems. Get an email whenever an error is detected.

## Requirements
You need to have a smtp-forwarder installed and properly configured to use this tool.

I recommend [Nullmailer](https://wiki.archlinux.org/title/Nullmailer) as it is pretty easy to configure.

## Configuration
The main config file is located at `/etc/conf.d/btrfs-monitor`. Use this to specify the destination email address for status messages.

## Usage
This application uses systemd timers to perform hourly checks on specified mount points.

These mount points are specified in the command to enable the timer, exactly like how `btrfs-scrub@.timer` works.

To get your systemd escaped path simply use the below command:

`systemd-escape -p /path/to/mountpoint`

And then enable the timer with:

`systemctl enable --now btrfs-monitor@previous-command-output.timer`

## Future development
- Add more status sources and more verbose messages
