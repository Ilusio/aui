#!/bin/bash

block_list=(`lsblk | grep 'part\|lvm' | awk '{print substr($1,3)}'`)

# check if there is no partition
if [[ ${#block_list[@]} -eq 0 ]]; then
    echo "No partition found"
    exit 0
fi

partitions_list=()
for OPT in ${block_list[@]}; do
check_lvm=`echo $OPT | grep lvm`
if [[ -z $check_lvm ]]; then
    partitions_list+=("/dev/$OPT")
else
    partitions_list+=("/dev/mapper/$OPT")
fi
done

partition_name=("boot" "swap" "root" "home")
partitions_choice=()
i=0
for OPT in ${partition_name[@]}; do
    echo -e "Select ${BYellow}${partition_name[i]}${Reset} partition:\n"
      select partition in "${partitions_list[@]}"; do
        #get the selected number - 1
        partition_choice+=$(( $REPLY - 1 ))
    i=$(( i + 1 ))
done

for number in ${partition_choice[@]}; do
    echo $number
    echo $partitions_list[$number]
done
#loadkeys fr-pc
#timedatectl set-ntp true
#cp ./mirrorlist /etc/pacman.d/mirrorlist
#chmod +r /etc/pacman.d/mirrorlist
