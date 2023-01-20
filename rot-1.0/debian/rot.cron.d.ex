#
# Regular cron jobs for the rot package
#
0 4	* * *	root	[ -x /usr/bin/rot_maintenance ] && /usr/bin/rot_maintenance
