#!/bin/sh
mkdir -p /tmp/dockmonitor
chmod 0777 /tmp/dockmonitor
{
    echo ---DOCKING EVENT START---

    # wait for the dock state to change in sysfs
    sleep 0.5

    date | tee /tmp/dockmonitor/last0
    cat /sys/devices/platform/dock.*/docked | tee /tmp/dockmonitor/states

    # check if at least one file contains a '1', this means we are docked
    if cat /sys/devices/platform/dock.*/docked | grep -q 1; then
	echo Docking
	
	# execute users' docking scripts
	for user in $(w | tail -n+3 | cut -d' ' -f 1 | uniq)
	do
	    echo -e "\tChecking docking scripts for $user"
	    on_script=/home/"$user"/.config/dock/on
	    if [ -x "$on_script" ]; then
		echo -e "\tExecuting on-dock scripts for $user"
		sudo -i -u "$user" "$on_script" | tee /tmp/dockmonitor/output
		echo -e "\tExecuted on-dock scripts for $user"
	    else
		echo -e "\tNo script found for $user"
	    fi
	done
    else
	echo Undocking
	
	#undocked event - lets remove all connected outputs apart from LVDS
	for output in $(/usr/bin/xrandr -d :0.0 --verbose|grep " connected"|grep -v LVDS|awk '{print $1}')
	do
            /usr/bin/xrandr -d :0.0 --output $output --off
	done

	# execute users' undocking scripts
	for user in $(w | tail -n+3 | cut -d' ' -f 1 | uniq)
	do
	    off_script=/home/"$user"/.config/dock/off
	    if [ -x "$off_script" ]; then
		sudo -i -u "$user" "$off_script" | tee /tmp/dockmonitor/output
	    fi
	done
    
    fi
    date | tee /tmp/dockmonitor/last1
    echo ---DOCKING EVENT END---
} >> /tmp/dockmonitor/log 2>&1

exit 0
