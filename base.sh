#!/bin/bash
loadkeys ru
setfont cyr-sun16
clear
echo " 

Скрипт писал Порунцов Юрий

Порунцов Юрий https://vk.com/poruncov https://t.me/poruncov 

Скрипт поддерживает установку как в режиме UEFI, так и в режиме Legacy.

! Важная информация ! 

Вся разметка диска производиться только в cfdisk! 
Не забудьте указать 
для UEFI
type=EFI для boot раздела также указать 
type=linux для других разделов будущей системы ( root/swap(type=swap)/home раздела ) 
Legacy
type=linux для других разделов будущей системы ( root/swap(type=swap)/home раздела ) 
De--- на выбор KDE Lxde Xfce Gnome
Dm--- на выбор sddm lxdm gdm 
"
#####
echo " Вы действительно хотите продолжить установку?  "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " hello # sends right after the keypress
    echo ''
    [[ "$hello" =~ [^10] ]]
do
    :
done
 if [[ $hello == 1 ]]; then
  clear
  echo "Добро пожаловать в установщик Arch Linux"
  elif [[ $hello == 0 ]]; then
   exit   
fi
###
echo ""
echo "
Данный этап поможет вам избежать проблем с ключами 
Pacmаn, если использкуете не свежий образ Arch Linux для установки! "
echo " Обновим ключи?  "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " x_key 
    echo ''
    [[ "$x_key" =~ [^10] ]]
do
    :
done
 if [[ $x_key == 1 ]]; then
  clear
  pacman-key --refresh-keys 
  elif [[ $x_key == 0 ]]; then
   echo " Обновление ключей пропущено "   
fi
##
echo " здесь выберайте то каким режимом запущен установочный образ Arch Linux"
echo " Если вы загрузились в UEFI тогда "1" если Legacy тогда "2" "
echo " Режим legacy только для mbr-таблицы разделов, Uefi для Gpt- таблицы разделов" 
echo   ""
echo " UEFI( no grub ) или Grub-legcy? "
while 
    DIRUEFI="/sys/firmware/efi"

    if [ -d "$DIRDIRUEFI" ]; then # УЕФИ
        echo "На компьютере обнаружен UEFI. Рекомендуем производить установку в этом режиме"
    else # БИОС
        echo "На компьютере не поддерживается UEFI или система загружена в режиме Legacy."
    fi

    read -n1 -p  "
    1 - UEFI
    
    2 - Legacy
    
    0 - exit " menu # sends right after the keypress
    echo ''
    [[ "$menu" =~ [^120] ]]
do
    :
done
if [[ $menu == 1 ]]; then
clear

pacman -Sy --noconfirm
echo ""
lsblk -f
echo " Здесь вы можете удалить boot от старой системы, файлы Windows загрузчика не затрагиваются."
echo " если вам неоходио полность очистить boot раздел, то пропусите этот этап далее установка предложит отформатировать boot раздел "
echo " При установке дуал бут раздел не нужно форматировать!!! "
echo ""
echo 'Удалим старый загрузчик linux?'
while 
    read -n1 -p  "
    1 - Удалить старый загрузчик linux
    
    0 - пропустить. Данный этап можно пропустить, если устанока производится первый раз(и не были установлены другие дистрибутивы) " boots 
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
   echo " Отчиска boot раздела пропущена, далее вы сможете его отформаировать, если нужно."   
fi
#
pacman -Sy --noconfirm
##############################
lsblk -f
echo " Выбирайте "1", если ранее не производилась разметка диска и у вас нет разделов для Arch Linux "
echo ""
echo 'Нужна разметка диска?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " cfdisk # sends right after the keypress
    echo ''
    [[ "$cfdisk" =~ [^10] ]]
do
    :
done
 if [[ $cfdisk == 1 ]]; then
  read -p "Укажите диск (например sda или sdc) : " cfd
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " boots # sends right after the keypress
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " swap # sends right after the keypress
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
echo " Если у вас есть home раздел от предыдущей системы его можно не форматировать"
echo " Укажите имя пользователя от предыдущего дистрибутива, тогда система сама востановит бут раздел "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " homeF # sends right after the keypress
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " homes # sends right after the keypress
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
###################  раздел  ###############################################################
echo 'Добавим разделы  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'пропущено'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
  echo 'Добавим раздел диск "C" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskD # sends right after the keypress
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskE  # sends right after the keypress
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
  fi
################################################################################### 
 # смена зеркал  
echo " Для уменьшения вероятности ошибок рекомендуем не изменять зеркала во время установки." 
echo " Если не уверены в том, что смена зеркал вамм необходима, пропустите это действие"
echo " Сменим зеркала на mirror.yandex.ru для увеличения скорости загрузки пакетов?"
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
wget https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
  elif [[ $zerkala == 0 ]]; then
   echo 'смена зеркал пропущена.'   
fi
pacman -Sy --noconfirm
######
 echo "Если для подключения к интернету использовали Wi-Fi (wifi-menu), введите 1."
 echo ""
 echo " Если вы в настоящий момент не используете Wi-Fi, но планируете его использовать "
 echo " после установки, рекомендуем выбрать 1 " 
 echo ""
 echo 'Установка базовой системы, будете ли вы использовать wifi?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^10] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
 pacstrap /mnt base  base-devel wget  efibootmgr iw   wpa_supplicant dialog
 genfstab -U /mnt >> /mnt/etc/fstab
  elif [[ $x_pacstrap == 0 ]]; then
  pacstrap /mnt base  base-devel wget efibootmgr iw 
  genfstab -U /mnt >> /mnt/etc/fstab
  fi 
##################################################
clear
echo "Если вы производите установку используя Wifi, выбирайте 1 "
echo ""
echo "Если используется проводное подключение к сети, выбирайте 2 " 
echo ""
echo 'wifi или dhcpcd ?'
while 
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  wget -P /mnt https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/chroot.sh
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. проверь  интернет для продолжение установки в черуте || 2. chmod +x chroot.sh || 3.команда для запуска ./chroot.sh ' 
  arch-chroot /mnt      
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/chroot.sh)"
fi

echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -a
reboot  












#####################################
#####################################
## часть вторая
elif [[ $menu == 2 ]]; then 
echo "Добро пожаловать в установку ArchLinux режим GRUB-Legacy "
lsblk -f
echo ""
echo " Выберайте "1", если ранее не производилась разметка диска и у вас нет разделов для ArchLinux "
echo ""
echo 'Нужна разметка диска?'
while 
   read -n1 -p  "
   1 - да
    
   0 - нет: " cfdisk # sends right after the keypress
    echo ''
    [[ "$cfdisk" =~ [^10] ]]
do
   :
done
 if [[ $cfdisk == 1 ]]; then
read -p " Укажите диск (sda/sdb/sdc) " cfd
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
##
clear
lsblk -f  
echo ' добавим и отформатируем BOOT?'
echo " Если у вас уже имеется бут раздел от предыдущей системы, "
echo " то вам необходимо его форматировать - 1, если у вас бут раздел не вынесен на другой раздел тогда "
echo " этот этап можно пропустить - 2"
while 
    read -n1 -p  "
    1 - форматировать и монтировать на отдельный раздел
    
    2 - пропустить если бут раздела нет : " boots 
    echo ''
    [[ "$boots" =~ [^12] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Укажите BOOT раздел(sda/sdb 1.2.3.4 (sda7 например)):" bootd
  mkfs.ext2  /dev/$bootd -L boot
  mkdir /mnt/boot
  mount /dev/$bootd /mnt/boot
  elif [[ $boots == 2 ]]; then
 echo " продолжаем установку... "
fi   
###
lsblk -f
echo 'добавим swap раздел?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " swap # sends right after the keypress
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
###  
clear
lsblk -f
echo ' Форматируем home раздел?'
echo ""
echo " Если у вас есть home раздел от предыдущей системы его можно не форматировать"
echo " Укажите имя пользователя от предыдущего дистрибутива, тогда система сама востановит бут раздел "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " homeF # sends right after the keypress
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " homes # sends right after the keypress
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
###################  раздел  ###############################################################
echo 'Добавим разделы  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - да
    0 - нет: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'пропущено'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
echo 'Добавим раздел диск "C" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskD # sends right after the keypress
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
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskE  # sends right after the keypress
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
  fi
# смена зеркал  
echo " Для уменьшения вероятности ошибок рекомендуем не изменять зеркала во время установки." 
echo " Если не уверены в том, что смена зеркал вамм необходима, пропустите это действие"
echo " Сменим зеркала на mirror.yandex.ru для увеличения скорости загрузки пакетов?"
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
wget https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/zer
cat 'zer' > /etc/pacman.d/mirrorlist
rm zer
  elif [[ $zerkala == 0 ]]; then
   echo 'смена зеркал пропущена.'   
fi
pacman -Sy --noconfirm
 ################################################################################### 
echo ""
 echo " Если для подключения к интернету использовали Wi-Fi (wifi-menu), введите 1."
 echo ""
 echo " Если вы в настоящий момент не используете Wi-Fi, но планируете его использовать "
 echo " после установки, рекомендуем выбрать 1 " 
 echo ""
 echo ' Установка базовой системы, будете ли вы использовать wifi?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^10] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  pacstrap /mnt base  base-devel wget wpa_supplicant dialog
  genfstab -pU /mnt >> /mnt/etc/fstab
elif [[ $x_pacstrap == 0 ]]; then
  pacstrap /mnt base  base-devel wget 
  genfstab -pU /mnt >> /mnt/etc/fstab
fi 
 

###############################
clear
echo "Если вы производите установку используя Wifi, выбирайте 1 "
echo ""
echo "Если используется проводное подключение к сети, выбирайте 2 " 
echo ""
echo 'wifi или dhcpcd ?'
while 
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  wget -P /mnt https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/chroot.sh
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo 'Для продолжения установки проверьте соединение с интернетом и введите:
        2. chmod +x chroot.sh
        3. /chroot.sh ' 
  arch-chroot /mnt      
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/chroot.sh)"
fi

echo "#####################################################################"
echo "###################    Устанока завершена      ######################"
echo "#####################################################################"
umount -a
reboot  
##############################################
elif [[ $menu == 0 ]]; then
exit
fi
