#!/bin/sh
if [ -f $HOME/.config/polybar/polybarhidden ]; then 
  polybar-msg cmd show 
  bspc config top_padding 24
  rm $HOME/.config/polybar/polybarhidden 
else 
  polybar-msg cmd hide 
  bspc config top_padding 0 
  touch $HOME/.config/polybar/polybarhidden
fi
