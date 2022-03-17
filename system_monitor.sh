#!/bin/bash

#Removing the file if its already exist

if [[ -e /opt/system_monitor.txt ]]; then

        sudo rm -f /opt/system_monitor.txt
fi


#Defining the table
sudo echo "No. Name Usage Threshold Warning Hostname" > /opt/system_monitor.txt

#CPU usgae
#calc the cpu idle

cpu_idle=$(top -b -n 1 | grep Cpu | awk '{print $8}' | cut -d '.' -f 1)
cpu_usage=`expr 100 - $cpu_idle`
cpu_threshold=80

if [[ $cpu_usage -gt $cpu_threshold ]]; then

        sudo echo "1 Cpu_usage  $cpu_usage% $cpu_threshold% YES $(hostname)" >> /opt/system_monitor.txt
else
        sudo echo "1 Cpu_usage  $cpu_usage% $cpu_threshold% NO $(hostname)" >> /opt/system_monitor.txt
fi

#Ram Memory


ram_threshold=80
ram_usage=$(free -h | grep Mem | awk '{print $3/$2*100}'|xargs printf "%0.f") #RamUsage

if [[ $ram_usage -gt $ram_threshold ]]; then

        sudo echo "2 Ram_Usage $ram_usage% $ram_threshold%  YES $(hostname)" >> /opt/system_monitor.txt

else

        sudo echo "2 Ram_Usage $ram_usage% $ram_threshold%  NO $(hostname)" >> /opt/system_monitor.txt

fi


#Disk
disk_threshold=80
disk_usage=$(df . -h |egrep -v 'tmp'| awk '{print $1,$2,$3,$4}'| grep /dev | awk '{print $3/$2*100}' | xargs printf "%0.f")

if [[ $disk_usage -gt $disk_threshold ]]; then

        sudo echo "3 Disk_Usage $disk_usage% $disk_threshold%  YES $(hostname)" >> /opt/system_monitor.txt

else

        sudo echo "3 Disk_Usage $disk_usage% $disk_threshold%  NO $(hostname)" >> /opt/system_monitor.txt

fi

#Display output in table format
echo "                                                              "
echo "--------------------------------------------------------------"


sudo column -t /opt/system_monitor.txt


echo "--------------------------------------------------------------"

echo "                                                              "
