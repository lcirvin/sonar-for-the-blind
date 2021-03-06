#!/bin/sh

sudo apt-get -y install python-pyaudio

amixer cset numid=3 1
amixer sset 'PCM' 100%

mkdir /usr/local/bin/sonar
cp src/* /usr/local/bin/sonar
cp /etc/rc.local /usr/local/bin/sonar
sed "`cat /usr/local/bin/sonar/rc.local | grep -n \"exit 0\" | sed \"s/:/ /\" | awk '{print $1}' | tail -n1`s,exit 0,python /usr/local/bin/sonar/main.py \&," /usr/local/bin/sonar/rc.local > /etc/rc.local 
echo "amixer sset 'PCM' 100%" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local

apt-get -y remove --purge wolfram-engine triggerhappy anacron logrotate dbus dphys-swapfile xserver-common lightdm
insserv -r x11-common; apt-get -y autoremove --purge

apt-get -y install busybox-syslogd; dpkg --purge rsyslog

cat /boot/cmdline.txt | sed 's/$/ fastboot noswap ro/' > /boot/cmdline.txt

rm -rf /var/lib/dhcp /var/run /var/spool /var/lock
ln -s /tmp /var/lib/dhcp; ln -s /tmp /var/run; ln -s /tmp /var/spool; ln -s /tmp /var/lock

sed `cat /etc/systemd/system/dhcpcd5 | grep -n "PIDFile=/run/dhcpcd.pid" | sed "s/:/ /" | awk '{print $1}'`s,run,var/run, /etc/systemd/system/dhcpcd5 > /etc/systemd/system/dhcpcd5 

insserv -r bootlogs; insserv -r console-setup

sed `cat /etc/fstab | grep -n "/dev/mmcblk0p1" | sed "s/:/ /" | awk '{print $1}'`s/defaults/defaults,ro/ /etc/fstab > /etc/fstab 
sed `cat /etc/fstab | grep -n "/dev/mmcblk0p2" | sed "s/:/ /" | awk '{print $1}'`s/defaults,noatime/defaults,noatime,ro/ /etc/fstab > /etc/fstab 

