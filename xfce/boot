Пусть ssd >> sda
hdd >> sdb

SSD 
имеет таблицу 
sda1 >>  win
sda2 >>  boot windows efi	
sda3 >>  win 
sda4 >>  disk C
sda5 >>  disk D

HDD
sdb1  /
sdb2  /home
sdb3  swap


####################

setfont cyr-san16\

mount /dev/sdb1 /mnt
mkdir	/mnt/{boot,home)
mount /dev/sda2 /mnt/boot
mount /dev/sdb2 /mnt/home
swapon /dev/sdb3

Так же можно добавить в fstab разделы windows С и D

для этого 

mkdir /mnt/{C,D} << либо другие имена для каталогов, как душе угодно))))

mount /dev/sda4 /mnt/C
mount /dev/sda5 /mnt/D

pacstrap /mnt base linux linux-headers dhcpcd  which inetutils netctl base-devel wget  efibootmgr nano  linux-firmware wpa_supplicant dialog
genfstab -U /mnt > /mnt/etc/fstab 

arch-chroot /mnt /bin/bash

имя машины

настройка времени 

локали

добавление юзера

пароль для root и user

установка загрузчика

systemd-boot (UEfi)


bootctl install 

echo ' default arch ' > /boot/loader/loader.conf
echo ' timeout 10 ' >> /boot/loader/loader.conf
echo ' editor 0' >> /boot/loader/loader.conf
echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
echo 'linux  /vmlinuz-linux' >> /boot/loader/entries/arch.conf
#######

pacman -S amd-ucode --noconfirm
echo  'initrd /amd-ucode.img ' >> /boot/loader/entries/arch.conf

pacman -S intel-ucode  --noconfirm
echo ' initrd /intel-ucode.img ' >> /boot/loader/entries/arch.conf


#######
 
echo "initrd  /initramfs-linux.img" >> /boot/loader/entries/arch.conf
lsblk -f
echo " Укажите тот радел который будет после перезагрузки, то есть например "

echo " при установке с флешки ваш hdd может быть sdb, а после перезагрузки sda "

echo " выше видно что sdbX например примонтирован в /mnt, а после перезагрузки systemd будет искать корень на sdaX "

echo " если указать не правильный раздел система не загрузится "

echo " если у вас один hdd/ssd тогда это будет sda 99%"
echo ""
echo "options root=/dev/sdb1  rw >> /boot/loader/entries/arch.conf << sdb1 для примера....
###
hook для pacman для systemd-boot что бы загрузчик не умирал при обновлении systemd

cd /home/$username 
git clone https://aur.archlinux.org/systemd-boot-pacman-hook.git
chown -R $username:users /home/$username/systemd-boot-pacman-hook   
chown -R $username:users /home/$username/systemd-boot-pacman-hook/PKGBUILD 
cd /home/$username/systemd-boot-pacman-hook   
sudo -u $username makepkg -si --noconfirm  
rm -Rf /home/$username/systemd-boot-pacman-hook
cd /home/$username 
#
далее по чек листу....
