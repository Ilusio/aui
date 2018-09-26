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
partition_name=("boot" "swap" "root" "home")
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
mkfs.ext4 ${partition_choice[2]}
mkfs.ext4 ${partition_choice[3]}

# mount
mount ${partition_choice[2]} /mnt
swapon ${partition_choice[1]}
mkdir /mnt/home && mount ${partition_choice[3]} /mnt/home
mkdir -p /mnt/boot/efi && mount -t vfat ${partition_choice[0]} /mnt/boot/efi

# mirror list
cp ./mirrorlist /etc/pacman.d/mirrorlist
chmod +r /etc/pacman.d/mirrorlist

# installation 
pacstrap /mnt base base-devel  wireless_tools wpa_supplicant dialog

#configuration
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
read hostname
echo $hostname > /etc/hostname
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
cp ./locale.gen /etc/locale.gen
locale-gen
echo LANG="en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
echo KEYMAP=fr > /etc/vconsole.conf
mkinitcpio -p linux
passwd

pacman -S grub efibootmgr
mkdir -p /boot/efi/EFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Syu vim git xorg-server xorg-xinit 

useradd -G root -m jm
echo "jm ALL=(ALL) ALL"
echo "jm ALL=(root) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown, /usr/bin/pacman -Syu"

git clone https://aur.archlinux.org/package-query.git
cd package-query
yes | makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
yes | makepkg -si
cd ..