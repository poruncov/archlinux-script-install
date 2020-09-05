 
#!/bin/bash
echo 'скрипт второй настройка системы в chroot '
timedatectl set-ntp true
pacman -Syyu  --noconfirm
echo ""
read -p "Введите имя компьютера: " hostname
echo ""
echo " Используйте в имени только буквы латинского алфавита "
echo ""
read -p "Введите имя пользователя: " username

echo $hostname > /etc/hostname
echo ""
echo " Очистим папку конфигов, кеш, и скрытые каталоги в /home/$username от старой системы ? "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_rm      # sends right after the keypress
    echo ''
    [[ "$i_rm" =~ [^10] ]]
do
    :
done
if [[ $i_rm == 0 ]]; then
clear
echo " очистка пропущена "
elif [[ $i_rm == 1 ]]; then
rm -rf /home/$username/.*
clear
echo " очистка завершена "
fi  
#####################################
echo " Настроим localtime "
echo ""
echo " Укажите город(1-27) и нажмите Enter  "
 while 
    read   -p  "
    1 - Калининград        14 - Красноярск
    
    2 - Киев               15 - Магадан
    
    3 - Киров              16 - Новокузнецк
    
    4 - Минск              17 - Новосибирск
    
    5 - Москва             18 - Омск
    
    6 - Самара             19 - Уральск
    
    7 - Саратов            20 - Алматы
    
    8 - Ульяновск          21 - Среднеколымск

    9 - Запарожье          22 - Ташкент

    10 - Чита              23 - Тбилиси
    
    11 - Иркутск           24 - Томск
    
    12 - Стамбул           25 - Якутск
    
    13 - Камчатка          26 - Екатеринбург
    
                27 - Ереван


0 - пропустить  : " wm_sity 
    echo ''
    [[ $wm_sity -lt 0 ||$wm_sity -gt 27 || "$wm_sity" =~ [^12345670] ]]
do
    :
done
if [[ $wm_sity == 1 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Kaliningrad /etc/localtime
    echo " Калиниград "
elif [[ $wm_sity == 2 ]]; then
  ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
    echo " Киев  "
elif [[ $wm_sity == 3 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Kirov /etc/localtime
    echo " Киров  "
elif [[ $wm_sity == 4 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
    echo " Минск  "
elif [[ $wm_sity == 5 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
    echo " Москва  "
elif [[ $wm_sity == 6 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Samara /etc/localtime
    echo " Самара   "
elif [[ $wm_sity == 7 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Saratov /etc/localtime
    echo " Саратов   "
elif [[ $wm_sity == 8 ]]; then
   ln -sf /usr/share/zoneinfo/Europe/Ulyanovsk /etc/localtime
    echo " Ульяновск  "
elif [[ $wm_sity == 9 ]]; then
    ln -sf /usr/share/zoneinfo/Europe/Zaporozhye /etc/localtime
    echo " Запорожье "
elif [[ $wm_sity == 10 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Chita /etc/localtime
    echo " Чита "
elif [[ $wm_sity == 11 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Irkutsk /etc/localtime
    echo " Иркутск  "
elif [[ $wm_sity == 12 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Istanbul /etc/localtime
    echo " Стамбул  "
elif [[ $wm_sity == 13 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Kamchatka /etc/localtime
    echo " Камчатка "
elif [[ $wm_sity == 14 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Krasnoyarsk /etc/localtime
    echo " Красноярск "
elif [[ $wm_sity == 15 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Magadan /etc/localtime
    echo " Магадан   "
elif [[ $wm_sity == 16 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Novokuznetsk /etc/localtime
    echo " Новокузнецк   "
elif [[ $wm_sity == 17 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
    echo " Новосибирск  "
elif [[ $wm_sity == 18 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Omsk /etc/localtime
    echo " Омск "
elif [[ $wm_sity == 19 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Oral /etc/localtime
    echo " Уральск "
elif [[ $wm_sity == 20 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Almaty /etc/localtime
    echo " Алматы  "
elif [[ $wm_sity == 21 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Srednekolymsk /etc/localtime
    echo " Среднеколымск  "
elif [[ $wm_sity == 22 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Tashkent /etc/localtime
    echo " Ташкент "
elif [[ $wm_sity == 23 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Tbilisi /etc/localtime
    echo " Тбилиси "
elif [[ $wm_sity == 24 ]]; then
   ln -sf /usr/share/zoneinfo/Asia/Tomsk /etc/localtime
    echo " Томск   "
elif [[ $wm_sity == 25 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yakutsk /etc/localtime
    echo " Якутск   "
elif [[ $wm_sity == 26 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
    echo " Екатеринбург "
elif [[ $wm_sity == 27 ]]; then
    ln -sf /usr/share/zoneinfo/Asia/Yerevan /etc/localtime
    echo " Ереван "
elif [[ $wm_sity == 0 ]]; then
clear
echo " Этап пропущен "
echo ""
fi
#####################################
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf 
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
echo ""
echo " Укажите пароль для ROOT "
passwd

echo ""
useradd -m -g users -G wheel -s /bin/bash $username
echo ""
echo 'Добавляем пароль для пользователя '$username' '
echo ""
passwd $username
echo ""
echo " Данный этап можно пропустить если не уверены в своем выборе!!! " 
echo " "
echo 'Сменим зеркала  для увеличения скорости загрузки пакетов?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " zerkala # sends right after the keypress
    echo ' '
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
   if [[ $zerkala == 1 ]]; then
pacman -S reflector --noconfirm
reflector --verbose -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
  elif [[ $zerkala == 0 ]]; then
   echo 'смена зеркал пропущена.'   
fi
pacman -Syy
clear
lsblk -f
###########################################################################
echo ""
echo " Если установка производиться на vds тогда grub "
echo ""
echo " Если у вас версия UEFI моложе 2013г. тогда ставьте UEFI-grub "
echo ""
echo "Какой загрузчик установить UEFI(systemd или GRUB) или Grub-legacy"
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
    
    0 - ucode не добавляем : " i_cpu   # sends right after the keypress
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
read -p "Укажите ROOT(корневой) раздел для загрузчика (Не пyтать с Boot!!!) (пример  sda6,sdb3 или nvme0n1p2 ): " root
Proot=$(blkid -s PARTUUID /dev/$root | grep -oP '(?<=PARTUUID=").+?(?=")')
echo options root=PARTUUID=$Proot rw >> /boot/loader/entries/arch.conf
#
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
echo " Если на компьютере/сервере будет только один ArchLinux 

и вам не нужна мультибут  >>> тогда 2

если же установка рядом в Windows или другой OS тогда 1 "
echo ""
echo " Нужен мультибут (установка рядом с другой OS)? "
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
pacman -S grub   --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
elif [[ $i_grub == 1 ]]; then
pacman -S grub grub-customizer os-prober  --noconfirm
lsblk -f
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
grub-mkconfig -o /boot/grub/grub.cfg
echo " установка завершена "
fi  
elif [[ $t_bootloader == 3 ]]; then
pacman -S grub os-prober --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
fi
mkinitcpio -p linux
##########
echo ""
echo " Настроим Sudo? "
while 
    read -n1 -p  "
    1 - с паролем   
    
    2 - без пароля
    
    0 - Sudo не добавляем : " i_sudo   # sends right after the keypress
    echo ''
    [[ "$i_sudo" =~ [^120] ]]
do
    :
done
if [[ $i_sudo  == 0 ]]; then
clear
echo " Добавление sudo пропущено"
elif [[ $i_sudo  == 1 ]]; then
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
clear
echo " Sudo с запросом пароля установлено "
elif [[ $i_sudo  == 2 ]]; then
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
clear
echo " Sudo nopassword добавлено  "
fi
##########
echo ""
echo " Настроим multilib? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_multilib   # sends right after the keypress
    echo ''
    [[ "$i_multilib" =~ [^10] ]]
do
    :
done
if [[ $i_multilib  == 0 ]]; then
clear
echo " Добавление мультилиб репозитория  пропущено"
elif [[ $i_multilib  == 1 ]]; then
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
clear
echo " Multilib репозиторий добавлен"
fi
######
echo ""
echo " Если вам не нужен X-сервер, тогда выбирайте пункт '2'  "
echo ""
echo " Установка производиться на vds или на ПК? "
while 
    read -n1 -p  "
    1 - ПК  
    
    2 - vds : " i_xorg # sends right after the keypress
    echo ''
    [[ "$i_xorg" =~ [^12] ]]
do
    :
done
if [[ $i_xorg  == 1 ]]; then
echo ""
echo " Устанавливаем на виртуальную машину ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_vbox   # sends right after the keypress
    echo ''
    [[ "$i_vbox" =~ [^10] ]]
do
    :
done
if [[ $i_vbox  == 0 ]]; then
pacman -Sy xorg-server xorg-drivers --noconfirm
elif [[ $i_vbox  == 1 ]]; then
pacman -Sy xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils --noconfirm
fi
elif [[ $i_xorg  == 2 ]]; then
echo " установка на vds  "
fi
pacman -Syy
echo "#####################################################################"
echo ""
echo " Установим DE/WM? "
while 
    read -n1 -p  "
    1 - KDE(Plasma)
    
    2 - xfce 
    
    3 - gmome
    
    4 - lxde
    
    5 - Deepin

    6 - Mate

    7 - Lxqt
    
    8 - i3 (  конфиги стандартные, возможна установка с автовходом )

    0 - пропустить " x_de
    echo ''
    [[ "$x_de" =~ [^123456780] ]]
do
    :
done
if [[ $x_de == 0 ]]; then
  echo 'уcтановка DE пропущена' 
elif [[ $x_de == 1 ]]; then
pacman -S  plasma plasma-meta plasma-pa plasma-desktop kde-system-meta kde-utilities-meta kio-extras kwalletmanager latte-dock  konsole  kwalletmanager --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_kde   # sends right after the keypress
    echo ''
    [[ "$i_kde" =~ [^10] ]]
do
    :
done
if [[ $i_kde  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_kde  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec startplasma-x11 " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
pacman -R konqueror --noconfirm
clear
echo "Plasma KDE успешно установлена"
elif [[ $x_de == 2 ]]; then
pacman -S  xfce4  pavucontrol xfce4-goodies  --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_xfce   # sends right after the keypress
    echo ''
    [[ "$i_xfce" =~ [^10] ]]
do
    :
done
if [[ $i_xfce  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_xfce  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec startxfce4 " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
clear
echo "Xfce успешно установлено"
elif [[ $x_de == 3 ]]; then
pacman -S gnome gnome-extra  --noconfirm
clear
echo " Gnome успешно установлен " 
elif [[ $x_de == 4 ]]; then
pacman -S lxde --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_lxde   # sends right after the keypress
    echo ''
    [[ "$i_lxde" =~ [^10] ]]
do
    :
done
if [[ $i_lxde  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_lxde  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec startlxde " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
clear
echo " lxde успешно установлен "
elif [[ $x_de == 5 ]]; then
pacman -S deepin deepin-extra --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_deepin   # sends right after the keypress
    echo ''
    [[ "$i_deepin" =~ [^10] ]]
do
    :
done
if [[ $i_deepin  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_deepin  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec startdde  " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
clear
echo " Deepin успешно установлен "
elif [[ $x_de == 6 ]]; then
pacman -S  mate mate-extra  --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_mate   # sends right after the keypress
    echo ''
    [[ "$i_mate" =~ [^10] ]]
do
    :
done
if [[ $i_mate  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_mate  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec mate-session  " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
clear
echo " Mate успешно установлен "
elif [[ $x_de == 7 ]]; then
pacman -S lxqt lxqt-qtplugin lxqt-themes oxygen-icons xscreensaver --noconfirm
clear
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_lxqt   # sends right after the keypress
    echo ''
    [[ "$i_deepin" =~ [^10] ]]
do
    :
done
if [[ $i_lxqt  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_lxqt  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec startlxqt " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
clear
echo " Lxqt успешно установлен "
elif [[ $x_de == 8 ]]; then
pacman -S i3 i3-wm i3status dmenu --noconfirm
clear
echo ""
echo " Если желаете использовать 2 окружения тогда укажите 0  "
echo ""
echo " Нужен автовход без DM ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_i3w   # sends right after the keypress
    echo ''
    [[ "$i_i3w" =~ [^10] ]]
do
    :
done
if [[ $i_i3w  == 0 ]]; then
echo " буду использовами DM "
elif [[ $i_i3w  == 1 ]]; then
pacman -S xorg-xinit --noconfirm
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
chown $username:users /home/$username/.xinitrc
chmod +x /home/$username/.xinitrc
sed -i 52,55d /home/$username/.xinitrc
echo "exec i3 " >> /home/$username/.xinitrc
mkdir /etc/systemd/system/getty@tty1.service.d/
echo " [Service] " > /etc/systemd/system/getty@tty1.service.d/override.conf
echo " ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo   ExecStart=-/usr/bin/agetty --autologin $username --noclear %I 38400 linux >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo ' [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ' >> /etc/profile
fi
echo ""
echo " nitrogen - легкая программа для установки обоев на рабочий стол" 
echo ""
echo " Установим nitrogen? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_natro   # sends right after the keypress
    echo ''
    [[ "$i_natro" =~ [^10] ]]
do
    :
done
if [[ $i_natro  == 0 ]]; then
echo "yстановка пропущена"
elif [[ $i_natro  == 1 ]]; then
pacman -Sy nitrogen  --noconfirm
fi
echo " i3wm успешно установлен " 
fi
clear 
####
echo ""
echo " Установим еще одно DE/WM? "
while 
    read -n1 -p  "
    1 - KDE(Plasma)
    
    2 - xfce 
    
    3 - gmome
    
    4 - lxde
    
    5 - Deepin

    6 - Mate

    7 - Lxqt
    
    8 - i3 ( конфиги стандартные, не забудьте установить DM )

    0 - пропустить " x_de2
    echo ''
    [[ "$x_de2" =~ [^123456780] ]]
do
    :
done
if [[ $x_de2 == 0 ]]; then
  echo 'уcтановка DE пропущена' 
elif [[ $x_de2 == 1 ]]; then
pacman -S plasma plasma-meta plasma-pa plasma-desktop kde-system-meta kde-utilities-meta kio-extras kwalletmanager latte-dock  konsole  kwalletmanager --noconfirm
pacman -R konqueror --noconfirm
clear
echo "Plasma KDE успешно установлена"
elif [[ $x_de2 == 2 ]]; then
pacman -S  xfce4 pavucontrol xfce4-goodies  --noconfirm
clear
echo "Xfce успешно установлено"
elif [[ $x_de2 == 3 ]]; then
pacman -S gnome gnome-extra  --noconfirm
clear
echo " Gnome успешно установлен " 
elif [[ $x_de2 == 4 ]]; then
pacman -S lxde --noconfirm
clear
echo " lxde успешно установлен "
elif [[ $x_de2 == 5 ]]; then
pacman -S deepin deepin-extra
clear
echo " Deepin успешно установлен "
elif [[ $x_de2 == 6 ]]; then
pacman -S  mate mate-extra  --noconfirm
clear
echo " Mate успешно установлен "
elif [[ $x_de2 == 7 ]]; then
pacman -S lxqt lxqt-qtplugin lxqt-themes --noconfirm
clear
echo " Lxqt успешно установлен "
elif [[ $x_de2 == 8 ]]; then
pacman -S i3 i3-wm i3status  dmenu  --noconfirm
clear
echo " Установка i3 завершена "
echo ""
echo " nitrogen - легкая программа для установки обоев на рабочий стол" 
echo ""
echo " Установим nitrogen? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_natro   # sends right after the keypress
    echo ''
    [[ "$i_natro" =~ [^10] ]]
do
    :
done
if [[ $i_natro  == 0 ]]; then
echo "yстановка пропущена"
elif [[ $i_natro  == 1 ]]; then
pacman -Sy nitrogen  --noconfirm
fi 
fi
clear
echo "#####################################################################"
echo ""
echo " При установке i3  без dm, dm не ставим!!! " 
echo " 
Arch-wiki рекоендует для: 
kde      <-> sddm
Lxqt     <-> sddm
xfce(i3) <-> lightdm
lxde     <-> lightdm
Gnome    <-> gdm
Deepin   <-> lightdm
Mate     <-> lightdm "
echo ""
echo "Установка Менеджера входа в систему "
while 
    read -n1 -p  "
    1 - Sddm
    
    2 - lightdm 
    
    3 - gdm
    
    0 - пропустить: " i_dm # sends right after the keypress
    
    echo ''
    [[ "$i_dm" =~ [^1230] ]]
do
    :
done
if [[ $i_dm == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_dm == 1 ]]; then
pacman -S sddm sddm-kcm --noconfirm
systemctl enable sddm.service -f
clear
echo " установка sddm  завершена "
elif [[ $i_dm == 2 ]]; then
pacman -S lightdm lightdm-gtk-greeter-settings lightdm-gtk-greeter --noconfirm
systemctl enable lightdm.service -f
clear
echo " установка lightdm завершена "
elif [[ $i_dm == 3 ]]; then
pacman -S gdm --noconfirm
systemctl enable gdm.service -f
clear
echo " установка gdm завершена "
fi
echo "#####################################################################"
echo ""
echo " Нужен NetworkManager ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_network   # sends right after the keypress
    echo ''
    [[ "$i_network" =~ [^10] ]]
do
    :
done
if [[ $i_network  == 1 ]]; then
pacman -Sy networkmanager networkmanager-openvpn network-manager-applet ppp --noconfirm
systemctl enable NetworkManager.service
elif [[ $i_network  == 0 ]]; then
echo " Установка NetworkManager пропущена "
echo ""
echo " Добавим dhcpcd в автозагрузку( для проводного интернета, который  получает настройки от роутера ) ? "
echo ""
echo "при необходимости это можно будет сделать уже в установленной системе "
while 
    read -n1 -p  "
    1 - включить dhcpcd 
    
    0 - не включать dhcpcd " x_dhcpcd
    echo ''
    [[ "$x_dhcpcd" =~ [^10] ]]
do
    :
done
if [[ $x_dhcpcd == 0 ]]; then
  echo ' dhcpcd не включен в автозагрузку, при необходиости это можно будет сделать уже в установленной системе ' 
elif [[ $x_dhcpcd == 1 ]]; then
systemctl enable dhcpcd.service
clear
echo "Dhcpcd успешно добавлен в автозагрузку"
fi
fi
clear
echo ""
echo " Нужна поддержка звука ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_sound   # sends right after the keypress
    echo ''
    [[ "$i_sound" =~ [^10] ]]
do
    :
done
if [[ $i_sound  == 1 ]]; then
pacman -Sy pulseaudio-bluetooth alsa-utils pulseaudio-equalizer-ladspa   --noconfirm
systemctl enable bluetooth.service
elif [[ $i_sound  == 0 ]]; then
echo " Установка пропущена "
fi
####
clear
echo ""
echo " Нужна поддержка ntfs и fat ? "
while 
    read -n1 -p  "
    1 - да  
    
    0 - нет : " i_fat   # sends right after the keypress
    echo ''
    [[ "$i_fat" =~ [^10] ]]
do
    :
done
if [[ $i_fat  == 1 ]]; then
pacman -Sy exfat-utils ntfs-3g   --noconfirm
elif [[ $i_fat == 0 ]]; then
echo " Установка пропущена "
fi
#####
clear
echo ""
echo " Нужны программы для работы с архивами? "
while 
    read -n1 -p  "
    1 - ark ( Plasma(kde)- так же можно и для другого de )  
    
    2 - file-roller легковесный архиватор ( для xfce-lxqt-lxde-gnome ) 
    
    0 - нет : " i_zip   # sends right after the keypress
    echo ''
    [[ "$i_zip" =~ [^120] ]]
do
    :
done
if [[ $i_zip  == 1 ]]; then
pacman -Sy unzip unrar  lha ark --noconfirm
elif [[ $i_zip == 2 ]]; then
pacman -Sy unzip unrar lha file-roller p7zip unace lrzip  --noconfirm  
elif [[ $i_zip == 0 ]]; then
echo " Установка пропущена "
fi
clear
echo ""
echo " Установка дополнительных программ ( установка всех программ по желанию )  "
echo ""
echo " 
>> blueman     
>> htop                
>> fiezilla 
>> gwenview               
>> steam 
>> neofetch
>> screenfetch
>> vlc
>> gparted  
>> telegram-desktop 
>> spectacle
>> flameshot"
echo ""
while 
    read -n1 -p  "
    1 - да ( буду устанавливать! )
    
    
    0 - пропустить ( Установка программ произвадиться не будет! )  " i_prog # sends right after the keypress
    echo ''
    [[ "$i_prog" =~ [^10] ]]
do
    :
done
if [[ $i_prog == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_prog == 1 ]]; then
echo "#############################################################################"
echo ""
echo " Будете ли вы подключать Android или Iphone к ПК через USB? "
while 
    read -n1 -p  "
    1 - Android 
    
    2 - Iphone 
    
    3 - оба варианта
    
    0 - пропустить: " i_telephone # sends right after the keypress
    
    echo ''
    [[ "$i_telephone" =~ [^1230] ]]
do
    :
done
if [[ $i_telephone == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_telephone == 1 ]]; then
pacman -S gvfs-mtp --noconfirm
clear
echo " установка gvfs-mtp  завершена "
elif [[ $i_telephone == 2 ]]; then
pacman -S gvfs-afc --noconfirm
clear
echo " установка gvfs-afc  завершена "
elif [[ $i_telephone == 3 ]]; then
pacman -S gvfs-afc gvfs-mtp --noconfirm
clear
echo " установка gvfs-afc gvfs-mtp  завершена "
fi
echo "#############################################################################"
echo ""
echo " blueman --диспетчер blutooth устройств  "
echo " "
echo " полезно для i3 " 
while 
    read -n1 -p  "
    1 - да 
    
    0 - нет: " i_blu # sends right after the keypress
    echo ''
    [[ "$i_blu" =~ [^10] ]]
do
    :
done
if [[ $i_blu == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_blu == 1 ]]; then
pacman -S blueman --noconfirm
clear
echo " установка blueman завершена "
fi


echo "#############################################################################"
echo ""
echo " htop--диспетчер задач для linux  "
echo " "
echo " При установке для i3 терминал xterm по умолчанию " 
while 
    read -n1 -p  "
    1 - да 
    
    0 - нет: " i_htop # sends right after the keypress
    echo ''
    [[ "$i_htop" =~ [^10] ]]
do
    :
done
if [[ $i_htop == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_htop == 1 ]]; then
pacman -S htop xterm --noconfirm
clear
echo " установка htop  завершена "
fi
#############  filezilla ###############
echo "#############################################################################"
echo ""
echo " Filezilla - графический клиент для работы с FTP/SFTP "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_filezilla    # sends right after the keypress
    echo ''
    [[ "$i_filezilla" =~ [^10] ]]
do
    :
done
if [[ $i_filezilla == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_filezilla == 1 ]]; then
pacman -S filezilla --noconfirm
clear
echo " Установка завершена "
fi  
echo "#############################################################################"
echo ""
echo " gwenview - программа для просмотра изображений для gnome и xfce есть собственное"
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_gwenview    # sends right after the keypress
    echo ''
    [[ "$i_gwenview" =~ [^10] ]]
do
    :
done
if [[ $i_gwenview == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_gwenview == 1 ]]; then
pacman -S gwenview --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " Steam - магазин игр   "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_steam    # sends right after the keypress
    echo ''
    [[ "$i_steam" =~ [^10] ]]
do
    :
done
if [[ $i_steam == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_steam == 1 ]]; then
pacman -S steam steam-native-runtime --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " neofetch - вывод данных о системе с лого в консоли "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_neofetch     # sends right after the keypress
    echo ''
    [[ "$i_neofetch" =~ [^10] ]]
do
    :
done
if [[ $i_neofetch  == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_neofetch  == 1 ]]; then
pacman -S neofetch  --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " screenfetch - вывод данных о системе с лого в консоли( аналог neofetch ) "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_screenfetch     # sends right after the keypress
    echo ''
    [[ "$i_screenfetch" =~ [^10] ]]
do
    :
done
if [[ $i_screenfetch  == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_screenfetch  == 1 ]]; then
pacman -S screenfetch  --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " vlc - проигрыватель мультимедиа ) "
while 
    read -n1 -p  "
    1 - да 
    
    0 - нет: " i_vlc   # sends right after the keypress
    echo ''
    [[ "$i_vlc" =~ [^10] ]]
do
    :
done
if [[ $i_vlc  == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_vlc  == 1 ]]; then
pacman -S vlc  --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " gparted - программа для работы с разделами sdd/hdd ) "
while 
    read -n1 -p  "
    1 - да 
    
    0 - нет: " i_gparted   # sends right after the keypress
    echo ''
    [[ "$i_gparted" =~ [^10] ]]
do
    :
done
if [[ $i_gparted  == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_gparted  == 1 ]]; then
pacman -S gparted  --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " telegram - мессенджер ) "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " i_telegram   # sends right after the keypress
    echo ''
    [[ "$i_telegram" =~ [^10] ]]
do
    :
done
if [[ $i_telegram  == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_telegram  == 1 ]]; then
pacman -S telegram-desktop   --noconfirm
clear
echo " Установка завершена "
fi

echo "#############################################################################"
echo ""
echo " установим программу для создания скриншотов? "
echo ""
echo " spectacle(интегрируется в рабочий стол  Plasma(kde)) и flameshot(универсальна, хорошо работает в KDE и Xfce) "
while 
    read -n1 -p  "
    1 - spectacle
    
    2 -flameshot 
    
    3 - оба варианта   
    
    0 - пропустить: " i_screen   # sends right after the keypress
    echo ''
    [[ "$i_screen" =~ [^1230] ]]
do
    :
done
if [[ $i_screen == 0 ]]; then
clear
echo " Установка пропущена "
elif [[ $i_screen == 1 ]]; then
pacman -S spectacle   --noconfirm
clear
echo " Установка завершена "
elif [[ $i_screen == 2 ]]; then
pacman -S flameshot --noconfirm
clear
echo " Установка завершена "
elif [[ $i_screen == 3 ]]; then
pacman -S spectacle flameshot --noconfirm
clear
echo " установка завершена "
fi
fi
###############################################################################
pacman -S  ttf-arphic-ukai git ttf-liberation ttf-dejavu ttf-arphic-uming ttf-fireflysung ttf-sazanami --noconfirm
clear
echo "################################################################"
echo ""
echo " Установим браузер? : "
while 
    read -n1 -p  "
    1 - google-chrome 
    
    2 - firefox 
    
    3 - chromium
    
    4 - opera ( + pepper-flash )
    
    5 - установить все
    
    0 - пропустить: " g_chrome # sends right after the keypress
    echo ''
    [[ "$g_chrome" =~ [^123450] ]]
do
    :
done
if [[ $g_chrome == 0 ]]; then
  echo ' установка браузера пропущена после установки системы вы сможете установить браузер на свой усмотрение!!!!' 
elif [[ $g_chrome == 1 ]]; then
cd /home/$username   
git clone https://aur.archlinux.org/google-chrome.git
chown -R $username:users /home/$username/google-chrome 
chown -R $username:users /home/$username/google-chrome/PKGBUILD 
cd /home/$username/google-chrome  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/google-chrome
clear
elif [[ $g_chrome == 2 ]]; then
pacman -S firefox firefox-i18n-ru --noconfirm 
clear
elif [[ $g_chrome == 3 ]]; then
pacman -S chromium --noconfirm 
elif [[ $g_chrome == 4 ]]; then
pacman -S opera pepper-flash --noconfirm 
elif [[ $g_chrome == 5 ]]; then
pacman -S chromium opera pepper-flash firefox firefox-developer-edition-i18n-ru --noconfirm 
cd /home/$username   
git clone https://aur.archlinux.org/google-chrome.git
chown -R $username:users /home/$username/google-chrome 
chown -R $username:users /home/$username/google-chrome/PKGBUILD 
cd /home/$username/google-chrome  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/google-chrome
clear
fi
#############################################################################
echo ""
echo ""
echo " установим офисный пакет libreoffice  для работы с документами? : "
while 
    read -n1 -p  "
    1 - да 
    
    0 - нет: " t_office # sends right after the keypress
    echo ''
    [[ "$t_office" =~ [^1230] ]]
do
    :
done
if [[ $t_office == 0 ]]; then
    clear
    echo ' установка пропущена ' 
elif [[ $t_office == 1 ]]; then
pacman -S libreoffice-still libreoffice-still-ru --noconfirm
clear
echo " установка libreoffice завершена "
fi
#############################################################################
echo ""
echo " Установим ssh(клиент) для удаленного доступа ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_ssh # sends right after the keypress
    echo ''
    [[ "$t_ssh" =~ [^10] ]]
do
    :
done
if [[ $t_ssh == 0 ]]; then
  echo 'уcтановка  пропущена' 
elif [[ $t_ssh == 1 ]]; then
pacman -S openssh --noconfirm
clear
echo ""
echo " Включим в автозагрузку ssh(server) для удаленного доступа к этому пк ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_ssh1 # sends right after the keypress
    echo ''
    [[ "$t_ssh1" =~ [^10] ]]
do
    :
done
if [[ $t_ssh1 == 0 ]]; then
clear
  echo ' сервис sshd не включен' 
elif [[ $t_ssh1 == 1 ]]; then
systemctl enable sshd.service
clear
fi
fi
echo "######    ZSH   #####"
echo ""
echo " установим zsh(такой же, как и в установочном образе Archlinux) или оставим Bash по умолчанию ? "
echo ""
echo "при необходимости можно будет установить другую оболочку в уже установленной системе "
while 
    read -n1 -p  "
    1 - установить zsh 
    2 - оставим bash по умолчанию " x_shell
    echo ''
    [[ "$x_shell" =~ [^12] ]]
do
    :
done
if [[ $x_shell == 0 ]]; then
clear
  echo ' оболочка не изменена, по умолчанию bash!"  ' 
elif [[ $x_shell == 1 ]]; then
clear
pacman -S zsh  zsh-syntax-highlighting zsh-autosuggestions grml-zsh-config --noconfirm
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /etc/zsh/zshrc
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /etc/zsh/zshrc
echo 'prompt adam2' >> /etc/zsh/zshrc
clear
echo " сменим оболочку пользователя с bash на zsh? "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_shell # sends right after the keypress
    echo ''
    [[ "$t_shell" =~ [^10] ]]
do
    :
done
if [[ $t_shell == 0 ]]; then
clear
echo 'пользовательская оболочка не изменена ( по умолчанию BASH )' 
elif [[ $t_shell == 1 ]]; then
chsh -s /bin/zsh
chsh -s /bin/zsh $username
clear
echo " при первом запуске консоли(терминала) нажмите "0" "
echo " оболочка изменена с bash на zsh "
fi
fi
echo "#############################################################################"
pacman -Sy --noconfirm
##############################################
echo ""
echo ""
echo "##################################################################################"
echo "###################   <<<< установка программ из AUR >>>    ######################"
echo "##################################################################################"
echo ""
echo "    каждую из программ можно будет пропустить! "
echo ""
###########################################################################
echo " Установим  aur-helper ( pikaur-(идет как зависимость для octopi) или yay ) ?  "
while 
    read -n1 -p  "
    1 - pikaur
    
    2 - yay 
    
    0 - пропустить : " in_aur_help # sends right after the keypress
    echo ''
    [[ "$in_aur_help" =~ [^120] ]]
do
    :
done
if [[ $in_aur_help == 0 ]]; then
  echo ' установка  пропущена' 
elif [[ $in_aur_help == 1 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/pikaur.git
chown -R $username:users /home/$username/pikaur   
chown -R $username:users /home/$username/pikaur/PKGBUILD 
cd /home/$username/pikaur   
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/pikaur
elif [[ $in_aur_help == 2 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/yay.git
chown -R $username:users /home/$username/yay
chown -R $username:users /home/$username/yay/PKGBUILD 
cd /home/$username/yay  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/yay
clear
fi
echo "################################################################"
echo ""
echo " Установим teamviewer для удаленного доступа ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_teamviewer # sends right after the keypress
    echo ''
    [[ "$t_teamviewer" =~ [^10] ]]
do
    :
done
if [[ $t_teamviewer == 0 ]]; then
  echo 'уcтановка  пропущена' 
elif [[ $t_teamviewer == 1 ]]; then
cd /home/$username 
git clone https://aur.archlinux.org/teamviewer.git
chown -R $username:users /home/$username/teamviewer
chown -R $username:users /home/$username/teamviewer/PKGBUILD 
cd /home/$username/teamviewer  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/teamviewer
systemctl enable teamviewerd.service
clear
fi
echo "################################################################"
echo ""
echo " Установим vk-messenger ? : "
while 
    read -n1 -p  "
    1 - да,
    
    0 - нет: " t_vk # sends right after the keypress
    echo ''
    [[ "$t_vk" =~ [^10] ]]
do
    :
done
if [[ $t_vk == 0 ]]; then
  echo 'уcтановка  пропущена' 
elif [[ $t_vk == 1 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/gconf.git 
chown -R $username:users /home/$username/gconf
chown -R $username:users /home/$username/gconf/PKGBUILD 
cd /home/$username/gconf  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/gconf
###
cd /home/$username
git clone https://aur.archlinux.org/vk-messenger.git
chown -R $username:users /home/$username/vk-messenger
chown -R $username:users /home/$username/vk-messenger/PKGBUILD 
cd /home/$username/vk-messenger  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/vk-messenger
#####
clear
fi

echo "################################################################"
echo ""
echo " Установим woeusb (Программа для записи Windows.iso на USB-накопитель)  ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_woeusb # sends right after the keypress
    echo ''
    [[ "$t_woeusb" =~ [^10] ]]
do
    :
done
if [[ $t_woeusb == 0 ]]; then
clear
  echo 'уcтановка  пропущена' 
elif [[ $t_woeusb == 1 ]]; then
cd /home/$username 
git clone https://aur.archlinux.org/woeusb.git
chown -R $username:users /home/$username/woeusb
chown -R $username:users /home/$username/woeusb/PKGBUILD 
cd /home/$username/woeusb  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/woeusb
clear
fi
echo "################################################################"
echo ""
echo " Установим alsi (альтернатива neofetch и screenfetch)  ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_alsi # sends right after the keypress
    echo ''
    [[ "$t_alsi" =~ [^10] ]]
do
    :
done
if [[ $t_alsi == 0 ]]; then
clear
  echo 'уcтановка  пропущена' 
elif [[ $t_alsi == 1 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/alsi.git
chown -R $username:users /home/$username/alsi
chown -R $username:users /home/$username/alsi/PKGBUILD 
cd /home/$username/alsi  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/alsi
clear
fi
echo "################################################################"
echo ""
echo " Установим inxi ( подробная информация о системе )  ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_inxi # sends right after the keypress
    echo ''
    [[ "$t_inxi" =~ [^10] ]]
do
    :
done
if [[ $t_inxi == 0 ]]; then
clear
  echo 'уcтановка  пропущена' 
elif [[ $t_inxi == 1 ]]; then
cd /home/$username 
git clone https://aur.archlinux.org/inxi.git
chown -R $username:users /home/$username/inxi
chown -R $username:users /home/$username/inxi/PKGBUILD 
cd /home/$username/inxi  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/inxi
clear
fi
echo "################################################################"
echo ""
echo " Установим графический менеджер пакетов для Archlinux ? : "
while 
    read -n1 -p  "
    1 - octopi 
    
    2 - pamac-aur
    
    0 - пропустить : " t_aur # sends right after the keypress
    echo ''
    [[ "$t_aur" =~ [^120] ]]
do
    :
done
if [[ $t_aur == 0 ]]; then
  echo 'уcтановка  пропущена' 
elif [[ $t_aur == 1 ]]; then
echo " Был ли выбран ранее pikaur ? : "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " t_picaur # sends right after the keypress
    echo ''
    [[ "$t_picaur" =~ [^10] ]]
do
    :
done
if [[ $t_picaur == 0 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/pikaur.git
chown -R $username:users /home/$username/pikaur   
chown -R $username:users /home/$username/pikaur/PKGBUILD 
cd /home/$username/pikaur   
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/pikaur
#####
cd /home/$username
git clone https://aur.archlinux.org/alpm_octopi_utils.git
chown -R $username:users /home/$username/alpm_octopi_utils
chown -R $username:users /home/$username/alpm_octopi_utils/PKGBUILD 
cd /home/$username/alpm_octopi_utils
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/alpm_octopi_utils
################
cd /home/$username
git clone https://aur.archlinux.org/octopi.git
chown -R $username:users /home/$username/octopi
chown -R $username:users /home/$username/octopi/PKGBUILD 
cd /home/$username/octopi
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/octopi
######################
cd /home/$username
git clone https://aur.archlinux.org/libgksu.git
chown -R $username:users /home/$username/libgksu
chown -R $username:users /home/$username/libgksu/PKGBUILD 
cd /home/$username/libgksu
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/libgksu
######################
git clone https://aur.archlinux.org/gksu.git
chown -R $username:users /home/$username/gksu
chown -R $username:users /home/$username/gksu/PKGBUILD 
cd /home/$username/gksu
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/gksu
echo " Octopi успешно установлен "
elif [[ $t_picaur == 1 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/alpm_octopi_utils.git
chown -R $username:users /home/$username/alpm_octopi_utils
chown -R $username:users /home/$username/alpm_octopi_utils/PKGBUILD 
cd /home/$username/alpm_octopi_utils
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/alpm_octopi_utils
################
cd /home/$username
git clone https://aur.archlinux.org/libgksu.git
chown -R $username:users /home/$username/libgksu
chown -R $username:users /home/$username/libgksu/PKGBUILD 
cd /home/$username/libgksu
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/libgksu
################
cd /home/$username
git clone https://aur.archlinux.org/gksu.git
chown -R $username:users /home/$username/gksu
chown -R $username:users /home/$username/gksu/PKGBUILD 
cd /home/$username/gksu
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/gksu
#####
cd /home/$username
git clone https://aur.archlinux.org/octopi.git
chown -R $username:users /home/$username/octopi
chown -R $username:users /home/$username/octopi/PKGBUILD 
cd /home/$username/octopi
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/octopi
clear
echo " Octopi успешно установлен "
fi

elif [[ $t_aur == 2 ]]; then
cd /home/$username
 git clone https://aur.archlinux.org/pamac-aur.git
chown -R $username:users /home/$username/pamac-aur
chown -R $username:users /home/$username/pamac-aur/PKGBUILD 
cd /home/$username/pamac-aur
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/pamac-aur
clear
echo " Pamac-aur успешно установлен! "
fi 
echo "####################   Установка пакетов завершена   ############################################"
echo ""
echo "
Данный этап поможет исключить возможные ошибки при первом запуске системы 

Фаил откроется через редактор  !nano!"
echo ""
echo " Просмотрим//отредактируем /etc/fstab ?"
while 
    read -n1 -p  "1 - да, 0 - нет: " vm_fstab # sends right after the keypress
    echo ''
    [[ "$vm_fstab" =~ [^10] ]]
do
    :
done
if [[ $vm_fstab == 0 ]]; then
  echo 'этап пропущен' 
elif [[ $vm_fstab == 1 ]]; then
nano /etc/fstab
fi 
clear
echo "################################################################"
echo ""
echo "Создаем папки музыка, видео и т.д. в директории пользователя?"
while 
    read -n1 -p  "1 - да, 0 - нет: " vm_text # sends right after the keypress
    echo ''
    [[ "$vm_text" =~ [^10] ]]
do
    :
done
if [[ $vm_text == 0 ]]; then
  echo 'этап пропущен'  
 exit
elif [[ $vm_text == 1 ]]; then
  mkdir /home/$username/{Downloads,Music,Pictures,Videos,Documents,time}   
  chown -R $username:users  /home/$username/{Downloads,Music,Pictures,Videos,Documents,time}
exit
fi  
clear 
echo " Установка завершена для выхода введите >> exit << "
exit
exit
