#!/bin/bash
loadkeys ru
setfont cyr-sun16
echo ' скрипт первый '
echo ""
echo "ArchLinux режим загрузки UEFI noGrub plasma kde "
echo ""
echo " пакеты шрифтов для русского и юго-восточных языков "
echo ""
echo "Скрипт писал Порунцов Юрий"
echo ""
echo "Порунцов Юрий https://vk.com/poruncov https://t.me/poruncov "
echo ""
echo " важная информация, если производите разметку диска, то в cfdisk не забудьте указать type=EFI для boot раздела " 
echo ""
echo "также   указаь type=linux для других разделов будующей системы ( root и home раздела ) "
echo ""
echo "Если производиться переустановка системы а не чистая установка, вам необходимо остановить скрипт "
echo "примонтировать boot раздел в /mnt у удалить все кроме .EFI/boot и EFI/Microsoft (это загрузчик windows) "
echo " Если система ставить на чистый  hdd или переустановка без Windows  можно сразу запускать скрипт  " 
echo " и отформатировать boot раздел"
echo 'готовы приступить?'
echo ""
echo " список пакетов которые будут установлены pulseaudio-bluetooth  flameshot ark exfat-utils filezilla alsa-utils android-tools unzip  gwenview steam steam-native-runtime ktorrent  kwalletmanager speedtest-cli ntfs-3g spectacle vlc  telegram-desktop latte-dock  pulseaudio-equalizer-ladspa gparted unrar neofetch screenfetch lha zsh "
echo ""
echo " щрифты ttf-arphic-ukai  ttf-liberation ttf-dejavu ttf-arphic-uming ttf-fireflysung ttf-sazanami  "
echo ""
read -p "1 - да, 0 - нет " hello
 if [[ $hello == 1 ]]; then
  echo "Добро пожаловать в установку ArchLinux режим загрузки UEFI noGrub "
  elif [[ $hello == 0 ]]; then
   reboot   
fi

#######
wget ftp://poruncov.dlinkddns.com:2244/usb1_2/arch-install//zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
pacman -Sy --noconfirm
######
lsblk -f
echo 'Нужна разметка диска?'
read -p "1 - да, 0 - нет " cfdisk
 if [[ $cfdisk == 1 ]]; then
  read -p "Укажите диск (sda/sdb ( например sda )):" cfd
cfdisk /dev/$cfd
  elif [[ $cfdisk == 0 ]]; then
   echo 'разметка пропущена.'   
fi

######
lsblk -f
read -p "Укажите ROOT раздел(sda/sdb 1.2.3.4 (sda5 например)):" root
echo ""
mkfs.ext4 /dev/$root -L root
mount /dev/$root /mnt
echo ""
##################
lsblk -f
echo 'форматируем BOOT?'
read -p "1 - да, 0 - нет " boots
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




########################################################################
lsblk -f
echo 'добавим swap раздел?'
read -p "1 - да, 0 - нет " swap
 if [[ $swap == 1 ]]; then
  read -p "Укажите swap раздел(sda/sdb 1.2.3.4 (sda7 например)):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  elif [[ $swap == 0 ]]; then
   echo 'добавление swap раздела пропущено.'   
fi
############################################################################ 
clear
lsblk -f
echo 'Форматируем home раздел?'
read -p "1 - да, 0 - нет " homeF
   if [[ $homeF == 1 ]]; then
   read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
   mkfs.ext4 /dev/$home -L home
   elif [[ $homeF == 0 ]]; then
   echo 'Формаирыване домашнего раздела пропущено.'   
fi
echo 'Добавим раздел  HOME ?'
read -p " 1 - да, 0 - нет : " homes
   if [[ $homes == 0 ]]; then
     echo 'пропущено'
  elif [[ $homes == 1 ]]; then
    read -p "Укажите HOME раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
    mkdir /mnt/home 
    mount /dev/$home /mnt/home
  fi

##################################################################################
echo 'Добавим раздел диск "C" Windows?'
read -p " 1 - да, 0 - нет : " diskC
if [[ $diskC == 0 ]]; then
  echo 'пропущено'
  elif [[ $diskC == 1 ]]; then
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
echo 'Добавим раздел диск "D" Windows?'
read -p " 1 - да, 0 - нет : " diskD

if [[ $diskD == 1 ]]; then
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
 echo 'Добавим раздел диск "E" Windows?'
read -p " 1 - да, 0 - нет : " diskE
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
echo 'wifi или dhcpcd ?' 
read -p "1 - wifi, 2  - проводной dhcpcd : " int
if [[ $int == 1 ]]; then
  wget -P /mnt ftp://poruncov.dlinkddns.com:2244/usb1_2/arch-install/kde.sh 
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. проверь  интернет для продолжение установки в черуте || 2. chmod +x kde.sh || 3.команда для запуска ./kde.sh  >>> ' 
  arch-chroot /mnt      
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL ftp://poruncov.dlinkddns.com:2244/usb1_2/arch-install/kde.sh)"
  fi
  #######################################################################################
umount -a
reboot
exit





