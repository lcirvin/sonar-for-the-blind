#!/bin/sh

sudo apt-get install python-pyaudio

amixer cset numid=3 1
amixer sset 'PCM' 100%

apt-get remove --purge wolfram-engine triggerhappy anacron logrotate dbus dphys-swapfile xserver-common lightdm
insserv -r x11-common; apt-get autoremove --purge

apt-get install busybox-syslogd; dpkg --purge rsyslog

cat /boot/cmdline.txt | sed '/$/ fastboot noswap ro/' > /boot/cmdline.txt

rm -rf /var/lib/dhcp /var/run /var/spool /var/lock
ln -s /tmp /var/lib/dhcp; ln -s /tmp /var/run; ln -s /tmp /var/spool; ln -s /tmp /var/lock

sed "`cat /etc/systemd/system/dhcpcd5 | grep -n "PIDFile=/run/dhcpcd.pid" | sed "s/:/ /" | awk '{print }'`s,run,var/run," /etc/systemd/system/dhcpcd5 


