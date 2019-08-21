 
#!/bin/bash
echo 'скрипт второй'
timedatectl set-ntp true

wget https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
pacman -Syyu  --noconfirm
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
rm -rf /home/$username/.*
#####################################
echo " Настроим localtime "
while 
    read -n1 -p  "1 - Москва, 2 - Минск, 3 - Екатеринбург, 4 - Киев, 5 - Якутск, 6 - Саратов, 7 - пропустить(если нет вашего варианта) : " wm_time 
    echo ''
    [[ "$wm_time" =~ [^1234567] ]]
do
    :
done
if [[ $vm_time == 1 ]]; then
  ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
elif [[ $vm_time == 2 ]]; then
  ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
elif [[ $vm_time == 3 ]]; then  
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
elif [[ $vm_time == 4 ]]; then 
 ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime 
elif [[ $vm_time == 5 ]]; then
ln -sf /usr/share/zoneinfo/Asia/Yakutsk /etc/localtime
elif [[ $vm_time == 6 ]]; then
ln -sf /usr/share/zoneinfo/Europe/Saratov /etc/localtime
elif [[ $vm_time == 7 ]]; then 
 echo  " этап пропущен " 
fi
#####################################
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf 
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
passwd
echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $username
passwd $username

pacman -Syy
#############
bootctl install 
echo ' default arch ' > /boot/loader/loader.conf
echo ' timeout 10 ' >> /boot/loader/loader.conf
echo ' editor 0' >> /boot/loader/loader.conf
############
clear
lsblk -f
read -p "Укажите корневой раздел для загрузчика(пример sda4,sda6 ): " root
echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
echo 'linux   /vmlinuz-linux' >> /boot/loader/entries/arch.conf
echo 'initrd  /initramfs-linux.img' >> /boot/loader/entries/arch.conf
echo options root=/dev/$root rw >> /boot/loader/entries/arch.conf
mkinitcpio -p linux
pacman -S dialog wpa_supplicant --noconfirm
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy 
pacman -Sy xorg-server xorg-drivers --noconfirm
pacman -Sy linux-headers  plasma-meta kdebase  sddm sddm-kcm openssh networkmanager htop network-manager-applet ppp --noconfirm
pacman -R konqueror --noconfirm
pacman -Sy pulseaudio-bluetooth  flameshot ark exfat-utils filezilla alsa-utils android-tools unzip  gwenview steam steam-native-runtime ktorrent  kwalletmanager speedtest-cli ntfs-3g spectacle vlc  telegram-desktop latte-dock  pulseaudio-equalizer-ladspa gparted unrar neofetch screenfetch lha --noconfirm
pacman -S  ttf-arphic-ukai git ttf-liberation ttf-dejavu ttf-arphic-uming ttf-fireflysung ttf-sazanami --noconfirm
########################
echo "######    ZSH   #####"
pacman -S zsh  zsh-syntax-highlighting  grml-zsh-config --noconfirm
chsh -s /bin/zsh
chsh -s /bin/zsh $username
mkdir /home/$username/.zsh
wget  https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/help
cp help /home/$username/.zsh  
rm help
wget  https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/alias
cp alias /home/$username/.zsh
rm alias
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /etc/zsh/zshrc
echo 'prompt adam2' >> /etc/zsh/zshrc
echo  source  /home/$username/.zsh/alias >> /etc/zsh/zshrc

##########################
systemctl enable dhcpcd.service
systemctl enable sddm NetworkManager
systemctl enable sddm.service -f
systemctl enable bluetooth.service
systemctl enable sshd.service

pacman -Sy --noconfirm
##############################################
echo "##################################################################################"
echo "###################   <<<< установка программ из AUR >>>    ######################"
echo "##################################################################################"

############################
cd /home/$username 
git clone https://aur.archlinux.org/systemd-boot-pacman-hook.git
chown -R $username:users /home/$username/systemd-boot-pacman-hook   
chown -R $username:users /home/$username/systemd-boot-pacman-hook/PKGBUILD 
cd /home/$username/systemd-boot-pacman-hook   
sudo -u $username makepkg -si --noconfirm  
rm -Rf /home/$username/systemd-boot-pacman-hook
cd /home/$username 
clear
echo "    каждую из программ можно будет пропустить! "
echo ""
###########################################################################
echo " Уставливаем aur-helper ( pikaur или yay ) ?  "
while 
    read -n1 -p  "1 - pikaur, 2 - yay, 0 - пропустить : " in_aur_help # sends right after the keypress
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
echo " Уставливаем браузер google-chrome ? : "
while 
    read -n1 -p  "1 - да, 0 - нет: " g_chrome # sends right after the keypress
    echo ''
    [[ "$g_chrome" =~ [^10] ]]
do
    :
done
if [[ $g_chrome == 0 ]]; then
  echo ' установка  пропущена' 
elif [[ $g_chrome == 1 ]]; then
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
    read -n1 -p  "1 - да, 0 - нет: " t_teamviewer # sends right after the keypress
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
    read -n1 -p  "1 - да, 0 - нет: " t_vk # sends right after the keypress
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
    read -n1 -p  "1 - да, 0 - нет: " t_woeusb # sends right after the keypress
    echo ''
    [[ "$t_woeusb" =~ [^10] ]]
do
    :
done
if [[ $t_woeusb == 0 ]]; then
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
    read -n1 -p  "1 - да, 0 - нет: " t_alsi # sends right after the keypress
    echo ''
    [[ "$t_alsi" =~ [^10] ]]
do
    :
done
if [[ $t_alsi == 0 ]]; then
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
echo " Уставливаем inxi ( подробная информация о системе )  ? : "
while 
    read -n1 -p  "1 - да, 0 - нет: " t_inxi # sends right after the keypress
    echo ''
    [[ "$t_inxi" =~ [^10] ]]
do
    :
done
if [[ $t_inxi == 0 ]]; then
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
echo " Уставливаем octopi ( графический мереджер пакетов )  ? : "
while 
    read -n1 -p  "1 - octopi, 2 - pacaur, 0 - пропустить : " t_aur # sends right after the keypress
    echo ''
    [[ "$t_aur" =~ [^120] ]]
do
    :
done
if [[ $t_aur == 0 ]]; then
  echo 'уcтановка  пропущена' 
elif [[ $t_aur == 1 ]]; then

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
elif [[ $t_aur == 2 ]]; then
cd /home/$username
git clone https://aur.archlinux.org/auracle-git.git
chown -R $username:users /home/$username/auracle-git
chown -R $username:users /home/$username/auracle-git/PKGBUILD 
cd /home/$username/auracle-git
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/auracle-git
#######
cd /home/$username
git clone https://aur.archlinux.org/pacaur.git
chown -R $username:users /home/$username/pacaur
chown -R $username:users /home/$username/pacaur/PKGBUILD 
cd /home/$username/pacaur
sudo -u $username  makepkg -si --noconfirm  
rm -Rf /home/$username/pacaur
clear
fi 
echo "####################   Установка пакетов завершена   ############################################"
echo ""
echo "создаем папки музыка и т.д. в дериктории пользователя?"
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
  chown -R $username:users  /home/uriy/{Downloads,Music,Pictures,Videos,Documents,time}
fi
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
exit
