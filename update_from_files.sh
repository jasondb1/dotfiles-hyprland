#!/bin/sh

GITPATH=$HOME/git/dotfile-hyprland

#.config files
cp -r $HOME/.config/waybar 	./.config/
cp -r $HOME/.config/hypr	./.config/
cp -r $HOME/.config/rofi 	./.config/
cp -r $HOME/.config/mako	./.config/
cp -r $HOME/.config/mpv 	./.config/
cp -r $HOME/.config/kitty 	./.config/

#Themes
cp -r $HOME/bin 	./
cp -r $HOME/.icons 	./
cp -r $HOME/.themes ./
cp -r $HOME/.fonts 	./

#other
cp -r $HOME/.vimrc 	./
cp -r $HOME/.bashrc ./
cp -r $HOME/.vimrc 	./

#etc
sudo cp -r /etc/greetd ./etc/greetd
