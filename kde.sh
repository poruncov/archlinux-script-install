 
#!/bin/bash
echo 'скрипт второй настройка системы в chroot '
timedatectl set-ntp true
pacman -Syyu  --noconfirm
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
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
while 
    read -n1 -p  "
    1 - Москва
    
    2 - Минск
    
    3 - Екатеринбург
    
    4 - Киев
    
    5 - Якутск
    
    6 - Саратов
    
    7-  Новосибирск

    0 - пропустить(если нет вашего варианта) : " wm_time 
    echo ''
    [[ "$wm_time" =~ [^12345670] ]]
do
    :
done
if [[ $wm_time == 1 ]]; then
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo " Москва "
elif [[ $wm_time == 2 ]]; then
ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
echo "Минск"
elif [[ $wm_time == 3 ]]; then  
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
echo " Екатеринбург "
elif [[ $wm_time == 4 ]]; then 
ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime 
echo " Киев " 
elif [[ $wm_time == 5 ]]; then
ln -sf /usr/share/zoneinfo/Asia/Yakutsk /etc/localtime
echo " Якутск "
elif [[ $wm_time == 6 ]]; then
ln -sf /usr/share/zoneinfo/Europe/Saratov /etc/localtime
echo " Саратов "
elif [[ $wm_time == 7 ]]; then 
ln -sf /usr/share/zoneinfo/Asia/Novosibirsk /etc/localtime
echo " Новосибирск "
elif [[ $wm_time == 0 ]]; then 
clear
echo  " этап пропущен " 
fi
#####################################
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf 
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
echo " Укажите пароль для "ROOT" "
passwd
echo 'Добавляем пароль для пользователя '$username' '
useradd -m -g users -G wheel -s /bin/bash $username
passwd $username
echo ""
echo " Я рекомендую не изменять зеркала во время установки, для уменьшения вероятности ошибок " 
echo " Если не уверены в том что смена зеркал вамм необходима, тогда пропустите "
echo ""
echo 'Сменим зеркала на Россия\Беларусь для увеличения скорости загрузки пакетов?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " zerkala # sends right after the keypress
    echo ''
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
 if [[ $zerkala == 1 ]]; then
wget https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub-and-grub-install/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
  elif [[ $zerkala == 0 ]]; then
   echo 'смена зеркал пропущена.'   
fi
pacman -Syy
clear
lsblk -f
###########################################################################
echo ""
echo "Какой загрузчик установить UEFI(systemd) или Grub для legacy"
while 
    read -n1 -p  "
    1 - UEFI
    
    2 - GRUB(legacy): " t_bootloader # sends right after the keypress
    echo ''
    [[ "$t_bootloader" =~ [^12] ]]
do
    :
done
if [[ $t_bootloader == 1 ]]; then
bootctl install 
echo ' default arch ' > /boot/loader/loader.conf
echo ' timeout 10 ' >> /boot/loader/loader.conf
echo ' editor 0' >> /boot/loader/loader.conf
echo ""
echo " Укажите тот радел который будет после перезагрузки, то есть например "

echo " при установке с флешки ваш hdd может быть sdb, а после перезагрузки sda "

echo " выше видно что sdbX напривмер примонтирован в /mnt, а после перезагрузки systemd будет искать корень на sdaX "

echo " если указать не правильный раздел система не загрузится "

echo " если у вас один hdd/ssd тогда это будет sda 99%"
echo ""
read -p "Укажите ROOT  раздел для загрузчика(пример  sda6,sdb3 ): " root
echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
echo 'linux   /vmlinuz-linux' >> /boot/loader/entries/arch.conf
echo 'initrd  /initramfs-linux.img' >> /boot/loader/entries/arch.conf
echo options root=/dev/$root rw >> /boot/loader/entries/arch.conf
cd /home/$username 
git clone https://aur.archlinux.org/systemd-boot-pacman-hook.git
chown -R $username:users /home/$username/systemd-boot-pacman-hook   
chown -R $username:users /home/$username/systemd-boot-pacman-hook/PKGBUILD 
cd /home/$username/systemd-boot-pacman-hook   
sudo -u $username makepkg -si --noconfirm  
rm -Rf /home/$username/systemd-boot-pacman-hook
cd /home/$username 
clear
elif [[ $t_bootloader == 2 ]]; then
pacman -S grub grub-customizer os-prober
read -p "Укажите диск куда установить GRUB (sda/sdb): " x_boot
grub-install /dev/$x_boot
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
echo '%%wheel ALL=(ALL) ALL' >> /etc/sudoers
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
#######################
pacman -Syy 
pacman -Sy xorg-server xorg-drivers --noconfirm
pacman -Sy linux-headers networkmanager  network-manager-applet ppp --noconfirm
pacman -Sy pulseaudio-bluetooth  ark exfat-utils  alsa-utils  unzip  ntfs-3g pulseaudio-equalizer-ladspa  unrar  lha --noconfirm
echo "#####################################################################"
echo ""
echo " Arch-wiki рекоендует для kde-sddm, а для xfce-lxdm "
echo ""
echo " Установим DE? "
while 
    read -n1 -p  "
    1 - KDE(Plasma)+sddm 
    
    2 - xfce+lxdm 
    
    3 - kde+lxdm 
    
    4 - xfce+sddm 
    
    0 - пропустить " x_de
    echo ''
    [[ "$x_de" =~ [^12340] ]]
do
    :
done
if [[ $x_de == 0 ]]; then
  echo 'уcтановка DE пропущена' 
elif [[ $x_de == 1 ]]; then
pacman -S sddm sddm-kcm  plasma-meta kdebase kwalletmanager  latte-dock --noconfirm
pacman -R konqueror --noconfirm
systemctl enable sddm.service -f
clear
echo "Plasma KDE успешно установлена"
elif [[ $x_de == 2 ]]; then
pacman -S  xfce4 xfce4-goodies lxdm --noconfirm
systemctl enable lxdm
clear
echo "Xfce успешно установлено"
elif [[ $x_de == 3 ]]; then
pacman -S plasma-meta kdebase kwalletmanager latte-dock lxdm  --noconfirm
pacman -R konqueror --noconfirm
systemctl enable lxdm
clear
echo "Plasma KDE успешно установлена"
elif [[ $x_de == 4 ]]; then
pacman -S  xfce4 xfce4-goodies sddm sddm-kcm --noconfirm
systemctl enable sddm.service -f
clear
echo "Xfce успешно установлено"
fi
echo "#####################################################################"                                        
echo ""
echo " Установка дополнительных программ "
echo ""
echo " 
flameshot
filezilla 
htop
gparted
neofetch
screenfetch
gwenview
steam steam-native-runtime 
spectacle vlc  telegram-desktop  "
echo ""
echo " установим все или на ваш выбор? "
while 
    read -n1 -p  "
    1 - все
    
    2 - на выбор
    
    0 - пропустить " i_prog # sends right after the keypress
    echo ''
    [[ "$i_prog" =~ [^120] ]]
do
    :
done
if [[ $i_prog == 0 ]]; then
clear
echo " Устанока пропущена "
elif [[ $i_prog == 1 ]]; then
pacman -S flameshot filezilla htop gparted neofetch screenfetch gwenview steam steam-native-runtime spectacle vlc  gvfs-mtp gvfs-afc  telegram-desktop     --noconfirm
clear
echo " установка завершена "
elif [[ $i_prog == 2 ]]; then
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
echo " Устанока пропущена "
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
echo " htop--диспетер задач для linux "
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
echo " Устанока пропущена "
elif [[ $i_htop == 1 ]]; then
pacman -S htop --noconfirm
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
echo " Устанока пропущена "
elif [[ $i_filezilla == 1 ]]; then
pacman -S filezilla --noconfirm
clear
echo " Установка завершена "
fi  
echo "#############################################################################"
echo ""
echo " gwenview - программа для просмотра изображений  "
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
echo " Устанока пропущена "
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
echo " Усттанока пропущена "
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
echo " Устанока пропущена "
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
echo " Устанока пропущена "
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
echo " Устанока пропущена "
elif [[ $i_vlc  == 1 ]]; then
pacman -S vlc  --noconfirm
clear
echo " Установка завершена "
fi
echo "#############################################################################"
echo ""
echo " gparted - программа для работы с разделоми sdd/hdd ) "
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
echo " Устанока пропущена "
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
echo " Устанока пропущена "
elif [[ $i_telegram  == 1 ]]; then
pacman -S telegram-desktop   --noconfirm
clear
echo " Установка завершена "
fi

echo "#############################################################################"
echo ""
echo " установим программу для создания скриншотов? "
echo ""
echo " spectacle(интегрируеться в рабочий стол  Plasma(kde)) и flameshot(универсальна, хорошо работает в KDE и Xfce) "
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
echo " Устанока пропущена "
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
echo ""
echo " Уставливаем ssh(клиент) для удаленного доступа ? : "
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
fi
echo ""
echo " Вкличим в автозагрузку ssh(server) для удаленного доступа к этому пк ? : "
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
  echo ' сервис sshd не вкючен' 
elif [[ $t_ssh1 == 1 ]]; then
systemctl enable sshd.service
clear
fi
echo "#############################################################################"
echo "######    ZSH   #####"
echo ""
echo " установим zsh(такой же как и в установочном образе Archlinux) или оставим Bash по умолчанию ? "
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
  echo ' оболочка не изменета, по умолчанию bash!"  ' 
elif [[ $x_shell == 1 ]]; then
clear
pacman -S zsh  zsh-syntax-highlighting  grml-zsh-config --noconfirm
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /etc/zsh/zshrc
echo 'prompt adam2' >> /etc/zsh/zshrc
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
echo 'пользоватльская обочка не изменена ( по умолчанию BASH )' 
elif [[ $t_shell == 1 ]]; then
chsh -s /bin/zsh
chsh -s /bin/zsh $username
clear
echo " при первом запуске консоли(терминала) нажмите "0" "
echo " оболочка изменена с bash на zsh "
fi
fi
echo "#############################################################################"
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
echo ""
echo " Добавим dhcpcd в автозагрузку( для проводного интернета, который  получает настройки от роутера ) ? "
echo ""
echo "при необходиости это можно будет сделать уже в установленной системе "
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
echo " Уставливаем aur-helper ( pikaur(идет как зависимость для octopi) или yay ) ?  "
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
echo " Устанавливаем браузер? : "
while 
    read -n1 -p  "
    1 - google-chrome 
    
    2 - firefox(russian) 
    
    3 - установить оба
    
    0 - пропустить: " g_chrome # sends right after the keypress
    echo ''
    [[ "$g_chrome" =~ [^1230] ]]
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
pacman -S firefox firefox-developer-edition-i18n-ru --noconfirm 
clear
elif [[ $g_chrome == 3 ]]; then
pacman -S firefox firefox-developer-edition-i18n-ru --noconfirm 
cd /home/$username   
git clone https://aur.archlinux.org/google-chrome.git
chown -R $username:users /home/$username/google-chrome 
chown -R $username:users /home/$username/google-chrome/PKGBUILD 
cd /home/$username/google-chrome  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/google-chrome
clear
fi
echo "################################################################"
echo ""
echo " Уставливаем teamviewer для удаленного доступа ? : "
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
echo " Уставливаем vk-messenger ? : "
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
git clone https://aur.archlinux.org/vk-messenger.git
chown -R $username:users /home/$username/vk-messenger
chown -R $username:users /home/$username/vk-messenger/PKGBUILD 
cd /home/$username/vk-messenger  
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/vk-messenger
clear
fi

echo "################################################################"
########
echo " Уставливаем woeusb (Программа для записи Windows.iso на USB-накопитель)  ? : "
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
echo " Уставливаем alsi (альтернатива neofetch и screenfetch)  ? : "
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
echo " Устанавливаем inxi ( подробная информация о системе )  ? : "
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
echo " Уставливаем графический менеджер пакетов для Archlinux ? : "
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
clear
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
echo "Создаем папки музыка, видео и т.д. в дириктории пользователя?"
while 
    read -n1 -p  "1 - да, 0 - нет: " vm_text # sends right after the keypress
    echo ''
    [[ "$vm_text" =~ [^10] ]]
do
    :
done
if [[ $vm_text == 0 ]]; then
  echo 'этап пропущен' 
elif [[ $vm_text == 1 ]]; then
  mkdir /home/$username/{Downloads,Music,Pictures,Videos,Documents,time} 
  chown -R $username:users  /home/$username/{Downloads,Music,Pictures,Videos,Documents,time}
fi
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
exit    
