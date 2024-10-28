#! /bin/sh


## Install required packages
#_installPackagesPacman() {
    #toInstall=();
    #for pkg; do
        #if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            #echo "${pkg} is already installed.";
            #continue;
        #fi;
        #toInstall+=("${pkg}");
    #done;
    #if [[ "${toInstall[@]}" == "" ]] ; then
        ## echo "All pacman packages are already installed.";
        #return;
    #fi;
    #printf "Package not installed:\n%s\n" "${toInstall[@]}";
    #sudo pacman --noconfirm -S "${toInstall[@]}";
#}

## Required packages for the installer
#packages=(
    #"wget"
    #"unzip"
    #"gum"
    #"rsync"
    #"git"
#)



#install nvidia drivers
#nvidia-inst
nvidia-dkms [This one]

#install os type stuff
sudo pacman -S vim htop powertop neofetch jq
sudo pacman -S sway hyprland swaybg waybar rofi kitty brightnessctl  mako grim slurp wl-clipboard cliphist wf-recorder mpv bluez blueman nwg-look polkit-kde-agent qt5-wayland qt6-wayland bashtop
sudo pacman -S sway hypridle hyprlock pipewire wireplumber 
sudo pacman -S python python-pip python-pyquery
sudo pacman -S yt-dlp mpv

systemctl enable bluetooth
systemctl start bluetooth

#install gui stuff
sudo pacman -S otf-font-awesome gucharmap caja engrampa wf-recorder caja caja-share
sudo pacman -S geany thunderbird obs-studio okular timeshift qutebrowser keepassxc

yay -S wlogout
yay -S brave
#blueman???

#change sway to unsupported gpu
#/usr/share/wayland-sessions/sway.desktop
#replace Exec line Exec=sway with Exec=sway --unsupported-gpu
sudo 


#install steam
sudo pacman -S nvidia-utils lib32-nvidia-utils egl-wayland
sudo pacman -S steam

sudo pacman -S lutris retroarch


#Set default browser
unset BROWSER
xdg-settings set default-web-browser brave-browser.desktop

#or this
xdg-mime default brave-browser.desktop x-scheme-handler/https x-scheme-handler/http text/html

#nativfier - used to make webapps
yay -S nodejs-nativefier




#asusctl from https://asus-linux.org/guides/arch-guide/
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

#After that to get the repo add to your /etc/pacman.conf at the end:

#adduser to input group to display keyboard state
# sudo usermod -a -G input jason - not needed now

[g14]
Server = https://arch.asus-linux.org

pacman -Suy
pacman -S asusctl power-profiles-daemon
systemctl enable --now power-profiles-daemon.service




#timeshift
sudo visudo
jason ALL = NOPASSWD: /usr/bin/timeshift

#create a file .nascreds
username=[user]
password=[password]


##set max battery charge level
asusctl -c 65
sudo timeshift --create --comments "New Install" --tags D --snapshot-device /dev/nvme0n1p5

###KVM QEMU
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat python python-pip ebtables iptables
sudo systemctl enable libvirtd.service
sudo systemctl start  libvirtd.service
sudo usermod -a -G libvirt jason


#nvidia and asus
pacman -S supergfxctl switcheroo-control
systemctl enable --now supergfxd
systemctl enable --now switcheroo-control

pacman -S rog-control-center

## Fixing suspend/wakeup issues

Enable the services `nvidia-suspend.service`, `nvidia-hibernate.service` and `nvidia-resume.service`, they will be started by systemd when needed.

systemctl enable nvidia-suspend.service
systemctl enable nvidia-resume.service

Add `nvidia.NVreg_PreserveVideoMemoryAllocations=1` to your kernel parameters if you don't have it already.

{{< hint type=important >}} Suspend functions are currently broken on `nvidia-open-dkms` [due to a bug](https://github.com/NVIDIA/open-gpu-kernel-modules/issues/472), so make sure you're on `nvidia-dkms`. {{< /hint >}}


edit /etc/kernel/cmdline
nvidia.NVreg_PreserveVideoMemoryAllocations=1
sudo reinstall-kernels


#suspend
may need to be su
Add nvidia.NVreg_PreserveVideoMemoryAllocations=1 to your kernel parameters if you haven’t already.
add into options at /efi/loader/(current kernel).conf
edit /etc/kernel/cmdline

su
echo deep > /sys/power/mem_sleep

#############This one works
#Try this to figure out suspend issues
edit /etc/kernel/cmdline
GRUB_CMDLINE_LINUX="acpi_osi=! \"acpi_osi=Windows 2009\" mem_sleep_default=deep reboot=bios"
