#! /bin/bash

#debian add lines
deb http://deb.debian.org/debian/ sid main non-free contrib
deb-src http://deb.debian.org/debian/ sid main non-free contrib

sudo apt install git vim 
sudo apt install bluez bluemon xinput
sudo apt install geany thunderbird 

# awesome 
sudo apt install awesome feh picom lxappearance lxpolkit flameshot xclip rofi neofetch i3lock compton xinput network-manager-gnome i3lock-fancy
sudo apt install bspwm sxhkd polybar
pnmixer xfce4-power-manager fonts-roboto xbacklight qt5-style-plugins






sudo dpkg --add-architecture i386
sudo apt update

sudo apt install steam

---

#######Not working with SID but works with bullseye
# Trust Wine's gpg key
sudo wget -O- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor | sudo tee /usr/share/keyrings/winehq.gpg

echo deb [signed-by=/usr/share/keyrings/winehq.gpg] http://dl.winehq.org/wine-builds/debian/ bullseye main | sudo tee /etc/apt/sources.list.d/winehq.list

sudo apt edit-sources

# Install updated wine packages
sudo apt update
sudo apt install --install-recommends winehq-staging
---

sudo apt install winetricks



# Install vulkan drivers
sudo apt install libvulkan1 libvulkan1:i386


# Install Lutris
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_11/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list

wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_11/Release.key -O- | sudo apt-key add -

sudo apt update
sudo apt install lutris
