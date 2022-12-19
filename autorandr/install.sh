#!/bin/bash

# github.com/phillipberndt/autorandr
# Create profiles using:
# autorandr --save <profile>
sudo pip install autorandr

mkdir -p ~/.autorandr/postswitch.d
ln -sf $PWD/postswitch.d/restart-pulseaudio ~/.autorandr/postswitch.d/restart-pulseaudio

