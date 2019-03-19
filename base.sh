 
#!/bin/bash


loadkeys ru
setfont cyr-sun16
echo 'скрипт первый'
cat 'zer' > /etc/pacman.d/mirrorlist
pacman -Syu --noconfirm
#mkfs.ext4 /dev/sdb4 -L home
mkfs.ext4 /dev/sdb5 -L root
mkswap /dev/sdb6 -L swap


echo 'монтирывание'
echo
mount /dev/sdb5 /mnt
mkdir /mnt/home
mount /dev/sdb4 /mnt/home
swapon /dev/sdb6
echo
pacstrap /mnt base  base-devel 
echo 'fstab'
genfstab -U /mnt >> /mnt/etc/fstab  
echo
echo 
arch-chroot /mnt  
exit





