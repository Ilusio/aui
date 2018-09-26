#!/bin/bash

echo "Hostname : "
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