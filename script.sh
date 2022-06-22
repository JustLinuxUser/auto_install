#!/bin/bash
set -xe
fdisk /dev/sda <<EOF
g
n




w
EOF
mkfs.xfs /dev/sda1
mount /dev/sda1 /mnt
pacstrap /mnt
genfstab /mnt>/mnt/etc/fstab
arch-chroot /mnt bash -c '
pacman -Sy grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg'
reboot
