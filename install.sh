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
partition_choice=()
for name in ${partition_name[@]}; do
    echo -e "Select ${BYellow}${name}${Reset} partition:\n"
      select partition in "${partitions_list[@]}"; do
        partition_choice+=($partition)
        break
      done
done

mkfs.vfat -F32 ${partition_choice[0]}
mkswap ${partition_choice[1]}
mkfs.ext4 ${partition_choice[2]}
mkfs.ext4 ${partition_choice[3]}

mount ${partition_choice[2]} /mnt
swapon ${partition_choice[1]}
mkdir /mnt/home && mount ${partition_choice[3]} /mnt/home
mkdir -p /mnt/boot/efi && mount -t vfat ${partition_choice[0]} /mnt/boot/efi
#loadkeys fr-pc
#timedatectl set-ntp true
#cp ./mirrorlist /etc/pacman.d/mirrorlist
#chmod +r /etc/pacman.d/mirrorlist
