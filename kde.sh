 
#!/bin/bash
cat 'zer' > /etc/pacman.d/mirrorlist
echo 'скрипт второй'
rm -rf /home/uriy/.*
pacman -Sy --noconfirm
pacman -Syyu  --noconfirm
pacman -S wget --noconfirm
echo "uriy-pc" > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf 
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
passwd
useradd -m -g users -G wheel -s /bin/bash uriy
passwd uriy
mkinitcpio -p linux
pacman -Syy
pacman -S os-prober --noconfirm
pacman -S grub  --noconfirm
grub-install /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S dialog wpa_supplicant --noconfirm
echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy 
pacman -Sy xorg-server xorg-drivers --noconfirm
pacman -Sy linux-headers linux-zen linux-zen-headers plasma-meta kdebase  sddm sddm-kcm networkmanager network-manager-applet ppp --noconfirm
pacman -R konqueror --noconfirm

pacman -Sy grub-customizer  pulseaudio-bluetooth neofetch flameshot ark exfat-utils alsa-utils android-tools unzip  gwenview    ktorrent partitionmanager kwalletmanager  ntfs-3g spectacle vlc  telegram-desktop latte-dock kdeconnect  pulseaudio-equalizer-ladspa --noconfirm
pacman -S  ttf-arphic-ukai ttf-liberation ttf-dejavu ttf-arphic-uming ttf-fireflysung ttf-sazanami --noconfirm

########################
######    ZSH   #####
pacman -S zsh  zsh-syntax-highlighting  grml-zsh-config
chsh -s /bin/zsh
chsh -s /bin/zsh uriy
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /etc/zsh/zshrc
echo 'prompt adam2' >> /etc/zsh/zshrc

###########  алисы    ###################################

echo 'unalias ...' >> /etc/zsh/zshrc
echo 'unalias egrep' >> /etc/zsh/zshrc
echo 'unalias grep' >> /etc/zsh/zshrc 
echo 'unalias lsd' >> /etc/zsh/zshrc 
echo 'unalias help-zshglob' >> /etc/zsh/zshrc 
echo 'unalias insecscp' >> /etc/zsh/zshrc 
echo 'unalias insecssh' >> /etc/zsh/zshrc 
echo 'unalias keep' >> /etc/zsh/zshrc 
echo 'unalias l' >> /etc/zsh/zshrc 
echo 'unalias la' >> /etc/zsh/zshrc 
echo 'unalias lad' >> /etc/zsh/zshrc 
echo 'unalias lh' >> /etc/zsh/zshrc 
echo 'unalias ll' >> /etc/zsh/zshrc 
echo 'unalias llog' >> /etc/zsh/zshrc 
echo 'unalias new' >> /etc/zsh/zshrc 
echo 'unalias se' >> /etc/zsh/zshrc 
echo 'unalias term2iso' >> /etc/zsh/zshrc 
echo 'unalias tlog' >> /etc/zsh/zshrc 
echo 'unalias url-quote' >> /etc/zsh/zshrc 
echo 'unalias which-command' >> /etc/zsh/zshrc 
echo 'unalias da' >> /etc/zsh/zshrc 
echo 'unalias dir' >> /etc/zsh/zshrc 
echo 'unalias lse' >> /etc/zsh/zshrc 
echo 'unalias lsl' >> /etc/zsh/zshrc 
echo 'unalias lsnew' >> /etc/zsh/zshrc 
echo 'unalias lsnewdir' >> /etc/zsh/zshrc 
echo 'unalias lsold' >> /etc/zsh/zshrc 
echo 'unalias lsolddir' >> /etc/zsh/zshrc 
echo 'unalias lss' >> /etc/zsh/zshrc 
echo 'unalias lssmall' >> /etc/zsh/zshrc 
echo 'unalias rmcdir' >> /etc/zsh/zshrc 
echo 'unalias lsw' >> /etc/zsh/zshrc 
echo 'unalias term2utf' >> /etc/zsh/zshrc 
echo 'unalias lsx' >> /etc/zsh/zshrc 
echo 'unalias lsa' >> /etc/zsh/zshrc 
echo 'unalias lsbig' >> /etc/zsh/zshrc 
echo 'unalias ls' >> /etc/zsh/zshrc 
##########################################################
echo "alias ...=' cd ' " >> /etc/zsh/zshrc
echo "alias fi=' alsi ' " >> /etc/zsh/zshrc
echo "alias sy=' sudo pacman -Sy ' " >> /etc/zsh/zshrc
echo "alias py=' pacaur -Syu ' " >> /etc/zsh/zshrc
echo "alias s=' sudo ' " >> /etc/zsh/zshrc
echo "alias ss=' sudo su ' " >> /etc/zsh/zshrc
echo "alias yy=' sudo pacman -Syyu ' " >> /etc/zsh/zshrc
echo "alias h=' /etc/zsh/./help.sh '" >> /etc/zsh/zshrc
echo "alias del=' pacman -R '" >> /etc/zsh/zshrc
echo "alias ap=' sudo pacman -S '" >> /etc/zsh/zshrc
echo "alias q=' exit ' " >> /etc/zsh/zshrc
echo "alias pi=' pacaur -S ' " >> /etc/zsh/zshrc
echo "alias na=' nano '" >> /etc/zsh/zshrc
echo "alias re=' reboot '" >> /etc/zsh/zshrc 
echo "alias off=' poweroff '" >> /etc/zsh/zshrc 
echo "alias cli=' clear' " >> /etc/zsh/zshrc 
echo "alias se=' simple-extract'" >> /etc/zsh/zshrc 
###########################################################
cp help.sh /etc/zsh/  
chmod +x /etc/zsh/help.sh
##########################
systemctl enable dhcpcd.service
systemctl enable sddm NetworkManager
systemctl enable sddm.service -f
systemctl enable bluetooth.service
#mkdir /home/uriy/{Downloads,Music,Pictures,Videos,Documents,time}
#chown -R uriy:users  /home/uriy/{Downloads,Music,Pictures,Videos,Documents,time}
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
###set fish_greeting ""
exit
