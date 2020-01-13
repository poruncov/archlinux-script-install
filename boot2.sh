#!/bin/bash

echo ""
echo "Теперь выбирите, что вам подходит"
while 
    read -n1 -p  "
    1 - UEFI(systemd-boot )
  
    2 - GRUB(legacy)
    
    3 - UEFI-GRUB: " t_bootloader # sends right after the keypress
    
    echo ''
    [[ "$t_bootloader" =~ [^123] ]]
do
    :
done
if [[ $t_bootloader == 1 ]]; then
cd /boot
ls | grep -v EFI | xargs rm -rfv
cd /boot/EFI
ls | grep -v Boot | grep -v Microsoft | xargs rm -rfv
pacman -S linux
bootctl install 
clear
echo ' default arch ' > /boot/loader/loader.conf
echo ' timeout 10 ' >> /boot/loader/loader.conf
echo ' editor 0' >> /boot/loader/loader.conf
echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
echo "linux  /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo ""
echo " Добавим ucode cpu? "
while 
    read -n1 -p  "
    1 - amd  
    
    2 - intel
    
    0 - ucode не добавляем : " i_cpu   
    echo ''
    [[ "$i_cpu" =~ [^120] ]]
do
    :
done
if [[ $i_cpu == 0 ]]; then
clear
echo " Добавление ucode пропущено "
elif [[ $i_cpu  == 1 ]]; then
clear
pacman -S amd-ucode --noconfirm
echo  'initrd /amd-ucode.img ' >> /boot/loader/entries/arch.conf
elif [[ $i_cpu  == 2 ]]; then
clear
pacman -S intel-ucode  --noconfirm
echo ' initrd /intel-ucode.img ' >> /boot/loader/entries/arch.conf
fi
echo "initrd  /initramfs-linux.img" >> /boot/loader/entries/arch.conf
clear
lsblk -f
echo ""
echo " Укажите тот радел который будет после перезагрузки, то есть например "

echo " при установке с флешки ваш hdd может быть sdb, а после перезагрузки sda "

echo " выше видно что sdbX например примонтирован в /mnt, а после перезагрузки systemd будет искать корень на sdaX "

echo " если указать не правильный раздел система не загрузится "

echo " если у вас один hdd/ssd тогда это будет sda 99%"
echo ""
read -p "Укажите ROOT  раздел для загрузчика(пример  sda6,sdb3 ): " root
echo options root=/dev/$root rw >> /boot/loader/entries/arch.conf
#
read -p "Введите имя пользователя: " username
cd /home/$username 
git clone https://aur.archlinux.org/systemd-boot-pacman-hook.git
chown -R $username:users /home/$username/systemd-boot-pacman-hook   
chown -R $username:users /home/$username/systemd-boot-pacman-hook/PKGBUILD 
cd /home/$username/systemd-boot-pacman-hook   
sudo -u $username makepkg -si --noconfirm  
rm -Rf /home/$username/systemd-boot-pacman-hook
cd /home/$username 
#
clear
elif [[ $t_bootloader == 2 ]]; then
clear
echo " Востановим загрузчик Grub"
echo ""
echo "
1- МультиБУТ 

2- не мультилиб"
echo ""
while 
    read -n1 -p  "
    1 - да
    
    2 - нет: " i_grub      # sends right after the keypress
    echo ''
    [[ "$i_grub" =~ [^12] ]]
do
    :
done
if [[ $i_grub == 2 ]]; then
pacman -S grub  os-prober --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
elif [[ $i_grub == 1 ]]; then
pacman -S grub --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
fi  
elif [[ $t_bootloader == 3 ]]; then
cd /boot
ls | grep -v EFI | xargs rm -rfv
cd /boot/EFI
ls | grep -v Boot | grep -v Microsoft | xargs rm -rfv
pacman -S linux grub os-prober --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
fi
mkinitcpio -p linux

exit


