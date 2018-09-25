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

partition_name=("boot" "swap" "root" "home")
done

#loadkeys fr-pc
#timedatectl set-ntp true
#cp ./mirrorlist /etc/pacman.d/mirrorlist
#chmod +r /etc/pacman.d/mirrorlist
