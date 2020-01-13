#!/bin/bash
setfont cyr-sun16
echo " "
echo "Данный скрипт позволит востановить загрузчик системы "
echo "после переустановки Windows или каких либо других монипуляций!"
echo ""
echo "Востаноим загрузчик ArchLinux"
 ###################################################################################
echo ""
echo 'Есть отдельный раздел UEFI или legacy< Grub >?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " disk # sends right after the keypress
    echo ''
    [[ "$disk" =~ [^10] ]]
do
    :
done
if [[ $disk == 1 ]]; then
clear
lsblk -f
echo ""
read -p "Укажите Root раздел(sda/sdb 1.2.3.4 (sda5 например)):" root
mount /dev/$root /mnt
echo ""
read -p "Укажите Boot раздел(ТОЛЬКО ДЛЯ UEFI )(sda/sdb 1.2.3.4 (sda2 например)):" boot
mount /dev/$boot /mnt/boot
read -p "Укажите Home раздел(sda/sdb 1.2.3.4 (sda6 например)):" home
mount /dev/$home /mnt/home
######

 clear
 lsblk -f
  echo ""
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


######
clear
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
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
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
 clear
 lsblk -f
  echo ""
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
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
  clear
 lsblk -f
  echo ""
  read -p " Укажите диск "E" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDe
 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
  fi
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt  sh -c "$(curl -fsSL https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/boot2.sh)"
reboot
######
elif [[ $disk == 0 ]]; then
 lsblk -f
echo ""
read -p "Укажите Root раздел(sda/sdb 1.2.3.4 (sda4 например)):" root
mount /dev/$root /mnt
echo ""
#######
echo 'Добавим раздел Boot, если нету тогда не указываем!!!!!'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " boot # sends right after the keypress
    echo ''
    [[ "$boot" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
 clear
 lsblk -f
  echo ""
  read -p " Укажите раздел boot (sda/sdb 1.2.3.4 (sda1 например)) : " boot
  mount /dev/$boot /mnt/boot
  elif [[ $boot == 0 ]]; then
  echo 'пропущено'
  fi
#######
read -p "Укажите Home раздел(sda/sdb 1.2.3.4 (sda5 например)):" home
mount /dev/$home /mnt/home 
##########################################################
clear
lsblk -f
echo ""
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
#####
clear
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
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
 
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
 clear
 lsblk -f
  echo ""
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
  

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
  clear
 lsblk -f
  echo ""
  read -p " Укажите диск "E" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDe
  
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
  fi
genfstab -pU /mnt > /mnt/etc/fstab
arch-chroot /mnt  sh -c "$(curl -fsSL https://raw.githubusercontent.com/poruncov/archlinux-script-install/master/boot2.sh)" 
reboot
fi





