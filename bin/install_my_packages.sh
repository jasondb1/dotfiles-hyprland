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

#pacstrap command here

#TODO: add cli browser and go to arch setup wiki

#Base packages 
sudo pacman -S Linux Linux-headers linux-lts linux-lts-headers
sudo pacman -S efibootmgr dosfstools os-prober grub vim nano sudo net-tools
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
#uncomment the line that mentions os-prober to look for other linux systems
grub-install —target=x86_64-efi —efi-directory=/boot/efi —bootloader-id=GRUB 
grub-mkconfig -o /boot/grub/grub.cfg 

#install fonts
noto-fonts adobe-source-code-pro-fonts cantarell-fonts xorg-fonts-encodings

#ttf-ubuntu-font-family ttf-dejavu ttf-bitstream-vera ttf-liberation
#noto-fonts ttf-roboto ttf-opensans opendesktop-fonts cantarell-fonts
#freetype2 

#https://forum.endeavouros.com/t/how-to-get-rid-of-noto-fonts-clutter/5042/4
sudo pacman -Rdd noto-fonts
#add to /etc/pacman/conf
NoExtract  = usr/share/fonts/noto/* !*NotoMono-* !*NotoSansDisplay-* !*NotoSansLinearB-* !*NotoSansMono-* !*NotoSansSymbols* !*NotoSerif-* !*NotoSerifDisplay-*
#reinstall fonts needed
sudo pacman -S --asdeps noto-fonts
#choose meslo 48
sudo pacman -S ttf-font-nerd




#install os type stuff
pacman -S base-devel

#note ydotool is good for automation
sudo pacman -S vim htop jq
sudo pacman -S hyprland swaybg waybar rofi-wayland kitty brightnessctl  mako pavucontrol grim slurp wl-clipboard cliphist wf-recorder mpv bluez blueman nwg-look qt5-wayland qt6-wayland  power-profiles-daemon 
sudo pacman -S yad rofi-calc
sudo pacman -S breeze-icons obsidian-icon-set zenity bashtop ydotool
sudo pacman -S hypridle hyprland-qtutils hyprlock hyprpolkitagent hyprpicker pipewire wireplumber xdg-desktop-portal-hyprland xdg-desktop-portal xdg-desktop-portal-gtk
sudo pacman -S python python-pip python-pyquery
sudo pacman -S yt-dlp mpv
sudo pacman -S mupdf
xdg-mime default mupdf.desktop application/pdf
xdg-mime default org.geeqie.Geeqie.desktop image/png
xdg-mime default org.geeqie.Geeqie.desktop image/jpeg
xdg-mime default org.geeqie.Geeqie.desktop image/bmp

#printing
sudo pacman -S cups cups-pdf libcups system-config-printer gutenprint ghostwriter foomatic-db-gutenprint-ppds
sudo systectl enable cups.service
sudo systectl start cups.service
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service
#add canon printer
lpadmin -p CanonMF264 -E -v ipp://192.168.1.156/ipp/print -m everywhere

#alternates hplip brother brother-hl
#only do the following if wheel is not in /etc/cups/cups-files.conf
#sudo groupadd lpadmin
#sudo usermod -aG lpadmin $USER


#cups avahi
#generic PCL printer - set defaults 

systemctl enable bluetooth
systemctl start bluetooth
systemctl enable --now power-profiles-daemon.service

#install nvidia drivers
#nvidia-inst
nvidia-dkms [This one]

#install gui stuff
sudo pacman -S otf-font-awesome gucharmap caja engrampa xarchiver p7zip caja-share
sudo pacman -S geany thunderbird obsidian obs-studio okular timeshift qutebrowser keepassxc geeqie firefox

#also made ln -s /home/jason/ollama_llm_models /usr/share/ollama/.ollama/models

# installing ollama https://forum.gnoppix.org/t/ollama-on-arch-linux-a-guide-to-cpu-gpu-centric-computing/24
curl -fsSL https://ollama.com/install.sh | sh
sudo pacman -S cuda ollama-cuda
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=jason
Group=jason
Restart=always
RestartSec=3
Environment="PATH=/home/jason/bin:/home/jason/bin:/home/jason/.cargo/bin:/home/jason/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/jason/.lmstudio/bin:/home/jason/.lmstudio/bin:/home/jason/.lmstudio/bin"
Environment="OLLAMA_MODELS=/home/jason/ollama_llm_models"
Environment="OLLAMA_HOST=0.0.0.0"


[Install]
WantedBy=default.target



#greeter like sddm
sudo pacman -S greetd-regreet greetd-gtkgreet cage
#edit /etc/greetd/config.toml - relpace agretty with hyprland
#make config file
copy regreet files to /etc/greetd
sudo systemctl enable greetd

#change size of tmpfs in ram change to...30%
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
makepkg

yay -S wlogout
yay -S brave-bin

#blueman???

#change sway to unsupported gpu
#/usr/share/wayland-sessions/sway.desktop
#replace Exec line Exec=sway with Exec=sway --unsupported-gpu
sudo 



sudo pacman -S pacman-contrib
sudo pacman -S checkupdates

## ********NOTE: uncomment lines in /etc/pacman.conf to enable multilib *******
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



#docker
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER
*reboot
sudo pacman -S nvidia-container-toolkit
#This has gpu support
sudo vim /etc/systemd/system/ollama.service add environment variable Environment=OLAMA_HOST=0.0.0.0
#[Service]
#Environment="OLLAMA_HOST=0.0.0.0"
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main


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

sudo pacman -S asusctl rog-control-center

#pacman -S asusctl 
#yay -S asusctl
#yay -S rog-control-center

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
