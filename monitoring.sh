#!/bin/bash
arc_ker=$(uname -a)
phy_cpu=$(nproc)
vir_cpu=$(lscpu | awk 'NR==5 {printf "%s\n", $2}')
mem_use=$(free -m | awk 'NR==2 {printf "%s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2}')
disk_use=$(df -h | awk 'NR==4 {printf "%s/%sb (%.0f%%)\n", $3*1000, $2, $3*100/$2}')
c_load=$(vmstat | awk 'NR==3 {printf "%.1f%%", 100-$15}')
reboot=$(who -b | awk 'NR==1 {print $3, $4}')
cond=$(lsblk | grep "lvm" | wc -l)
if [ $cond -gt 0 ]
then
	lvm_check=$(echo yes)
else
	lvm_check=$(echo not)
fi
tcp=$(ss -t | grep -i estab | wc -l)
user=$(who | wc -l)
ip=$(hostname -I)
mac=$(ip a | grep -i ether | awk 'NR==1 {print $2}')
sudo=$(journalctl _COMM=sudo | grep -i command | wc -l)

wall "   |￣￣￣￣￣￣|
   |   HELLO!   |
   |＿＿＿＿＿＿|
   (\__/) ||
   (•ㅅ•) ||
   / 　 づ
   #Architecture: $arc_ker
   #CPU physical: $phy_cpu
   #vCPU: $vir_cpu
   #Memory Usage: $mem_use
   #Disk Usage: $disk_use
   #CPU load: $c_load
   #Last boot: $reboot
   #LVM use: $lvm_check
   #Connections TCP : $tcp ESTABLISHED
   #User log: $user
   #Network: $ip ($mac)
   #Sudo : $sudo cmd
"
