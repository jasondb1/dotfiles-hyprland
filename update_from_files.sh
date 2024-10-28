#!/bin/sh

GITPATH=$HOME/git/dotfile-hyprland

#.config files
cp -r $HOME/.config/waybar 	./.config/waybar
cp -r $HOME/.config/hypr	./.config/hypr
cp -r $HOME/.config/rofi 	./.config/rofi
cp -r $HOME/.config/mako	./.config/mako
cp -r $HOME/.config/mpv 	./.config/mpv
cp -r $HOME/.config/kitty 	./.config/kitty

#Themes
cp -r $HOME/bin 	./bin
cp -r $HOME/.icons 	./.icons
cp -r $HOME/.themes ./.themes
cp -r $HOME/.fonts 	./.fonts



#other
cp -r $HOME/.vimrc 	./
cp -r $HOME/.bashrc 	./
cp -r $HOME/.vimrc 	./
