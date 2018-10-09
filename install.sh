#!/bin/bash

# change keyboard layout
loadkeys fr-pc

#update time
timedatectl set-ntp true


# get partition
block_list=(`lsblk | grep 'part\|lvm' | awk '{print substr($1,3)}'`)

partitions_list=()
for OPT in ${block_list[@]}; do
check_lvm=`echo $OPT | grep lvm`
if [[ -z $check_lvm ]]; then
    partitions_list+=("/dev/$OPT")
else
    partitions_list+=("/dev/mapper/$OPT")
fi
done

# choose partitions
partition_name=("boot" "swap" "root")
partition_choice=()
for name in ${partition_name[@]}; do
    echo -e "Select ${BYellow}${name}${Reset} partition:\n"
      select partition in "${partitions_list[@]}"; do
        partition_choice+=($partition)
        break
      done
done

# format
mkfs.vfat -F32 ${partition_choice[0]}
mkswap ${partition_choice[1]}
cryptsetup -s 512 -h sha512 luksFormat --type luks2 ${partition_choice[2]}
cryptsetup open ${partition_choice[2]} cryptroot
mkfs.ext4 /dev/mapper/cryptroot

#cryptsetup -s 512 -h sha512 luksFormat --type luks2 ${partition_choice[3]}
#mkfs.ext4 ${partition_choice[2]}
#mkfs.ext4 ${partition_choice[3]}

# mount
mount /dev/mapper/cryptroot /mnt
swapon ${partition_choice[1]}
mkdir -p /mnt/boot/efi && mount -t vfat ${partition_choice[0]} /mnt/boot/efi

# mirror list
cp ./mirrorlist /etc/pacman.d/mirrorlist
chmod +r /etc/pacman.d/mirrorlist

# installation 
pacstrap /mnt base base-devel  wireless_tools wpa_supplicant dialog

#configuration
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
