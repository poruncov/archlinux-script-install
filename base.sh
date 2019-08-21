#!/bin/bash
loadkeys ru
setfont cyr-sun16
clear
echo ""
echo ' скрипт первый '
echo ""
echo " ArchLinux режим загрузки UEFI noGrub plasma kde "
echo ""
echo " Скрипт писал Порунцов Юрий"
echo ""
echo " Порунцов Юрий https://vk.com/poruncov https://t.me/poruncov "
echo ""
echo " важная информация, если производите разметку диска, то в cfdisk не забудьте указать type=EFI для boot раздела " 
echo ""
echo " также   указаь type=linux для других разделов будующей системы ( root/swap(type=swap)/home раздела ) "
echo ""
echo " список пакетов которые будут установлены : "
echo " pulseaudio-bluetooth  flameshot ark exfat-utils filezilla gparted unrar neofetch screenfetch "
echo " alsa-utils android-tools unzip  gwenview steam steam-native-runtime ktorrent  kwalletmanager "
echo " speedtest-cli ntfs-3g spectacle vlc  telegram-desktop latte-dock  pulseaudio-equalizer-ladspa "
echo "" 
echo " zsh(С таким же плагином и подцветкой как в усановочном образе archlinux ) "
echo ""
echo " щрифты ttf-arphic-ukai  ttf-liberation ttf-dejavu ttf-arphic-uming ttf-fireflysung ttf-sazanami  "
echo ""
####################################
echo " готовы приступить?  "
while 
    read -n1 -p  "1 - да, 0 - нет: " hello # sends right after the keypress
    echo ''
    [[ "$hello" =~ [^10] ]]
do
    :
done
 if [[ $hello == 1 ]]; then
  clear
  echo "Добро пожаловать в установку ArchLinux режим загрузки UEFI noGrub "
  elif [[ $hello == 0 ]]; then
   reboot   
fi
clear
#
wget https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
pacman -Sy --noconfirm
echo ""
lsblk -f
echo 'удалим старый загрузчик linux'
while 
    read -n1 -p  "1 - удалим старый загрузкик линукс? , 0 - данный этап можно пропустить если устанока производиться первый раз(и не были установлеены другие дистрибутивы) " boots # sends right after the keypress
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
read -p "Укажите boot раздел (sda2/sdb2 ( например sda2 )):" bootd
 mount /dev/$bootd /mnt
 cd /mnt
 ls | grep -v EFI | xargs rm -rfv
cd /mnt/EFI
ls | grep -v Boot | grep -v Microsoft | xargs rm -rfv
cd /root
umount /mnt
  elif [[ $boots == 0 ]]; then
   echo " очиска boot раздела пропущена, далее вы сможете его отфармаировать, если нужно!(при установке дуал бут раздел не нужно форматировать!!! "   
fi
#
wget https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
pacman -Sy --noconfirm
##############################
lsblk -f
echo ""
echo 'Нужна разметка диска?'
while 
    read -n1 -p  "1 - да, 0 - нет: " cfdisk # sends right after the keypress
    echo ''
    [[ "$cfdisk" =~ [^10] ]]
do
    :
done
 if [[ $cfdisk == 1 ]]; then
  read -p "Укажите диск (sda/sdb ( например sda )):" cfd
cfdisk /dev/$cfd
  elif [[ $cfdisk == 0 ]]; then
   echo 'разметка пропущена.'   
fi
#
read -p "Укажите ROOT раздел(sda/sdb 1.2.3.4 (sda5 например)):" root
echo ""
mkfs.ext4 /dev/$root -L root
mount /dev/$root /mnt
echo ""
########## boot  ########
clear
lsblk -f
echo 'форматируем BOOT?'
while 
    read -n1 -p  "1 - да, 0 - нет: " boots # sends right after the keypress
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Укажите BOOT раздел(sda/sdb 1.2.3.4 (sda7 например)):" bootd
  mkfs.fat -F32 /dev/$bootd
  mkdir /mnt/boot
  mount /dev/$bootd /mnt/boot
  elif [[ $boots == 0 ]]; then
 read -p "Укажите BOOT раздел(sda/sdb 1.2.3.4 (sda7 например)):" bootd 
 mkdir /mnt/boot
mount /dev/$bootd /mnt/boot
fi
############ swap   #########################################################
lsblk -f
echo 'добавим swap раздел?'
while 
    read -n1 -p  "1 - да, 0 - нет: " swap # sends right after the keypress
    echo ''
    [[ "$swap" =~ [^10] ]]
do
    :
done
 if [[ $swap == 1 ]]; then
  read -p "Укажите swap раздел(sda/sdb 1.2.3.4 (sda7 например)):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  elif [[ $swap == 0 ]]; then
   echo 'добавление swap раздела пропущено.'   
fi
################  home     ############################################################ 
clear
lsblk -f
echo 'Форматируем home раздел?'
while 
    read -n1 -p  "1 - да, 0 - нет: " homeF # sends right after the keypress
    echo ''
    [[ "$homeF" =~ [^10] ]]
do
    :
done
   if [[ $homeF == 1 ]]; then
   read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
   mkfs.ext4 /dev/$home -L home
   elif [[ $homeF == 0 ]]; then
   echo 'Формаирыване домашнего раздела пропущено.'   
fi
echo 'Добавим раздел  HOME ?'
while 
    read -n1 -p  "1 - да, 0 - нет: " homes # sends right after the keypress
    echo ''
    [[ "$homes" =~ [^10] ]]
do
    :
done
   if [[ $homes == 0 ]]; then
     echo 'пропущено'
  elif [[ $homes == 1 ]]; then
    read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
    mkdir /mnt/home 
    mount /dev/$home /mnt/home
  fi
###################  disk C  ###############################################################
echo 'Добавим раздел диск "C" Windows?'
while 
    read -n1 -p  "1 - да, 0 - нет: " diskC # sends right after the keypress
    echo ''
    [[ "$DiskC" =~ [^10] ]]
do
    :
done
if [[ $diskC == 0 ]]; then
  echo 'пропущено'
  elif [[ $diskC == 1 ]]; then
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
############### disk D ##############
echo 'Добавим раздел диск "D" Windows?'
while 
    read -n1 -p  "1 - да, 0 - нет: " diskD # sends right after the keypress
    echo ''
    [[ "$diskD" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskD == 0 ]]; then
  echo 'пропущено'
  fi
###### disk E ########
echo 'Добавим раздел диск "E" Windows?'
while 
    read -n1 -p  "1 - да, 0 - нет: " diskE  # sends right after the keypress
    echo ''
    [[ "$diskE" =~ [^10] ]]
do
    :
done
 if [[ $diskE == 1 ]]; then
  read -p " Укажите диск "E" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDe
  mkdir /mnt/E 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
 ################################################################################### 
pacstrap /mnt base  base-devel wget efibootmgr iw wpa_supplicant dialog
genfstab -U /mnt >> /mnt/etc/fstab
##################################################
clear
echo 'wifi или dhcpcd ?'
while 
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then
  wget -P /mnt https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/kde.sh
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. проверь  интернет для продолжение установки в черуте || 2. chmod +x kde.sh || 3.команда для запуска ./kde.sh  >>> ' 
  arch-chroot /mnt      
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/poruncov/archlinux-kde--script-install-uefi-nogrub/master/kde.sh)"
  fi
  #######################################################################################
umount -a
reboot
exit





