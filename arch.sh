#!/bin/bash
#setup time zone
timedatectl set-timezone America/New_York
systemctl enable systemd-timesyncd

~/.files/update.sh
#Installs archiving/compreshion Pacages
pacman -S p7zip p7zip-plugins unrar tar rsync zstd 
#Installs basic pacages
pacman -S --needed base-devel curl wget nano neovim firefox nemo nemo-extensions vlc flatpak
#Installs zsh
pacman -S zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Installs microcode Based on cpu
if [[ $(lscpu) == *AMD* ]]; then
  pacman -S amd-ucode
elif [[ $(lscpu) == *intel* ]]; then
  pacman -S intel-ucodepac
  pacman -S mesa
fi

#Installs xorg and nvida driver if needed
if [[ $Video == Y ]]; then
  pacman -S xorg-server
  if [[ $(lspci) == *NVIDIA* ]]; then
  pacman -S nvidia nvidia-utils
  fi
fi

#Installs and enables gui
pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
systemctl enable lightdm

#Installs yay
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

#installs genral pacages
yay -S --needed spotify minecraft-launcher jdk bat
#installs fonts
yay -S --needed adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gsfonts nerd-fonts-complete noto-fonts-cjk otf-font-awesome ttf-font-awesome ttf-ms-fonts ttf-font-awesome ttf-liberation ttf-ms-fonts ttf-opensans

#Installs discord and stuff for virtual camra
discord
yay -S discord obs-studio v4l2loopback-dkms

#Installs gaming resorces
yay -S --needed wine lutris steam
