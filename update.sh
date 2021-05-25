#!/bin/bash
#Checks if the system is arch 
if [[ $(uname -a) == *arch*  ]]; then
  #Checks if yay -s installed
  if [[ $(which yay) == /usr/bin/yay ]]; then
    #runs yay update
    yay -Syu --noconfirm
    yay -Yc
  else
    #Runs pacman update
    pacman -Syu --noconfirm
  fi
  #Checks if the system is ubuntu 
elif [[ $(uname -a) == *Ubuntu*  ]]; then
  #Runs apt update upgrad and auto remove
  sudo apt update && sudo apt upgrade -y && sudo apt autoremove
fi
