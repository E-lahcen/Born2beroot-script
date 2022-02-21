#!/bin/bash
wall $'#Architecture: ' `uname -a` \
$'\n#CPU physical: '`cat /proc/cpuinfo | grep processor | wc -l` \
$'\n#vCPU:  '`cat /proc/cpuinfo | grep processor | wc -l` \
$'\n'`free -m | awk 'NR==2{printf "#Memory Usage: %s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }'` \
$'\n'`df -h | awk '$NF=="/"{printf "#Disk Usage: %d/%dGB (%s)", $3,$2,$5}'` \
$'\n'`top -bn1 | grep load | awk '{printf "#CPU Load: %.2f%%", $(NF-2)}'` \
$'\n#Last boot: ' `who -b | awk '{printf "%s %s\n", $3, $4}'` \
$'\n#LVM use: ' `lsblk | awk '{printf "%s", $6}' | grep lvm | awk '{if ($1) {printf "yes";exit;} else {printf "no"} }'` \
$'\n#Connection TCP:' `netstat -an | grep ESTABLISHED |  wc -l` $'ESTABLISHED' \
$'\n#User log: ' `who | cut -d " " -f 1 | sort -u | wc -l` \
$'\n#Network: IP ' `hostname -I`"("`ip a | grep link/ether | awk '{printf "%s", $2}'`")" \
$'\n#Sudo: ' `grep --text 'COMMAND' /var/log/sudo/log_sudo | wc -l` $' cmd'