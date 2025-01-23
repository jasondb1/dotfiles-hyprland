#!/bin/bash 

if [ -z "$1" ]
  then
    echo "Set battery charge threshold to:" 
    read charge
else
  charge=$1
fi


sudo tlp setcharge BAT1 $charge
echo 'Battery charge:' $charge
sudo tlp-stat -b
#sudo tlp start
