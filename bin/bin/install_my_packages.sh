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

Base packages 
sudo pacman -S Linux Linux-headers linux-lts linux-lts-headers
sudo pacman -S efibootmgr dosfstools grub vim nano sudo net-tools
sudo pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber networkmanager man-db 

#firmware for my asus
linux-firmware-qlogic aic94xx-firmware wd719x-firmware ast-firmware

passwd # set main passsword
add users

edit /etc/hosts with 
127.0.0.1 localhost
::1 localhost
127.0.1.1 <your hosts name>

locale-gen
add wheel

sudo pacman -S ntp
systemctl enable ntpd
systemctl start ntpd


# set system time and set rtc to local timezone for windows to operate correctly
hwclock -l -w
sudo timedatectl set-local-rtc 1

#enable os_prober in /etc/default/grub
grub-install —target=x86_64-efi —efi-directory=/boot/EFI —bootloader-id=GRUB 
grub-mkconfig -o /boot/grub/grub.cfg 

#install fonts
noto-fonts adobe-source-code-pro-fonts cantarell-fonts xorg-fonts-encodings

#ttf-ubuntu-font-family ttf-dejavu ttf-bitstream-vera ttf-liberation
#noto-fonts ttf-roboto ttf-opensans opendesktop-fonts cantarell-fonts
#freetype2 





#install nvidia drivers
#nvidia-inst
nvidia-dkms [This one]

#install os type stuff
pacman -S base-devel



sudo pacman -S vim htop powertop neofetch jq
sudo pacman -S sway hyprland swaybg waybar rofi-wayland kitty brightnessctl  mako grim slurp wl-clipboard cliphist wf-recorder mpv bluez blueman nwg-look polkit-kde-agent qt5-wayland qt6-wayland bashtop power-profiles-daemon xdg-desktop-portal hyprpolkitagent
sudo pacman -S breeze-icons obsidian-icon-set pavucontrol zenity
sudo pacman -S sway hypridle hyprlock hyprpicker pipewire wireplumber 
sudo pacman -S python python-pip python-pyquery
sudo pacman -S yt-dlp mpv

#cups avahi
sudo pacman -S cups gutenprint ghostwriter foomatic-db-gutenprint-ppds
#generic PCL printer - set defaults 

systemctl enable bluetooth
systemctl start bluetooth
systemctl enable --now power-profiles-daemon.service

#install gui stuff
sudo pacman -S otf-font-awesome gucharmap caja engrampa xarchiver p7zip wf-recorder caja-share
sudo pacman -S geany thunderbird obsidian obs-studio okular timeshift qutebrowser keepassxc geeqie

#greeter like sddm
sudo pacman -S greetd-regreet greetd-gtkgreet
#edit /etc/greetd/config.toml - relpace agretty with hyprland
#make config file
copy regreet files to /etc/greetd
sudo systemctl enable greetd

#change size of tmpfs in ram
find line in /usr/lib/systemd/system/tmp.mount

#put .cache in tmpfs
$ mv ~/.cache ~/.cache.old
$ ln  -s  /tmp/home/jason/.cache  ~/.
and then added this to my ~/.profile:

mkdir  -p  /tmp/home/jason/.cache

#or 
cd ~/.cache
rm -rf BraveSoftware
ln -s /tmp BraveSoftware
After restarting Brave, you should now see its cache on /tmp

ls -laF /tmp/Brave-Browser
Occasionally check to see how close /tmp is to filling up:

df -h /tmp
If it’s getting full, tell Brave to clear its cache (in Settings / Privacy and security / Clear browsing data).




#TODO: possibly at waybar component to track cache and clean cache

git clone https://aur.archlinux.org/yay.git
yay -S hyprpolkitagent-git
yay -S hyprland-qtutils

yay -S wlogout
yay -S brave-bin
yay -S --noconfirm --quiet --needed ttf-ms-win11-auto
#blueman???

#change sway to unsupported gpu
#/usr/share/wayland-sessions/sway.desktop
#replace Exec line Exec=sway with Exec=sway --unsupported-gpu
sudo 

##NOTE: uncomment lines in /etc/pacman.conf to enable multilib
#install steam
sudo pacman -S nvidia-utils lib32-nvidia-utils egl-wayland nvtop
sudo pacman -S libva-nvidia-driver
sudo pacman -S steam

sudo pacman -S lutris retroarch


#Set default browser
unset BROWSER
xdg-settings set default-web-browser brave-browser.desktop

#or this
xdg-mime default brave-browser.desktop x-scheme-handler/https x-scheme-handler/http text/html

#nativfier - used to make webapps
yay -S nodejs-nativefier


sudo pacman -S pacman-contrib
sudo pacman -S checkupdates







#timeshift
sudo visudo
jason ALL=NOPASSWD: /usr/bin/timeshift
or
%sudo ALL=NOPASSWD: /usr/bin/timeshift
#edit this and put in correct backup device
/etc/timeshift/timeshift.json

#create a file .nascreds
username=[user]
password=[password]

###KVM QEMU Virtualization
#https://gist.github.com/tatumroaquin/c6464e1ccaef40fd098a4f31db61ab22
sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf swtpm guestfs-tools libosinfo tuned dnsmasq libguestfs ebtablesvde2 openbsd-netcat

#sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq bridge-utils libguestfs ebtables vde2 openbsd-netcat
#sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat python python-pip ebtables iptables
sudo systemctl enable libvirtd.service
sudo systemctl start  libvirtd.service
sudo usermod -a -G libvirt jason

#physical windows partition on kvm qemu
https://lejenome.tik.tn/post/boot-physical-windows-inside-qemu-guest-machine - look in comments as to how to size ntfs partition correctly
https://sysguides.com/install-a-windows-11-virtual-machine-on-kvm #Very good guide to install windows in kvm
https://simgunz.org/posts/2021-12-12-boot-windows-partition-from-linux-kvm/




############################ASUS
#asusctl from https://asus-linux.org/guides/arch-guide/
sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

#After that to get the repo add to your /etc/pacman.conf at the end:

[g14]
Server = https://arch.asus-linux.org

#pacman -S asusctl 
yay -S asusctl
yay -S rog-control-center

##set max battery charge level
asusctl -c 65
sudo timeshift --create --comments "New Install" --tags D --snapshot-device /dev/nvme0n1p5

#nvidia and asus
pacman -S supergfxctl switcheroo-control
systemctl enable --now supergfxd
systemctl enable --now switcheroo-control

pacman -S rog-control-center







##############################NVIDIA and 

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
