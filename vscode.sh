#!/bin/bash
#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

chmod 700 ~/.files/update.sh
~/.files/update.sh
#Installs archiving/compreshion Pacages
sudo pacman -S --needed p7zip unrar tar rsync zstd 
#Installs basic pacages
sudo pacman -S --needed base-devel curl wget nano neovim
#Installs zsh
sudo pacman -S --needed zsh && chsh -s /bin/zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#Installs yay
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

#installs genral pacages
yay -S --needed jdk bat code-server

#Links zsh and vim rc files
ln -fs ~/.files/vimrc ~/.vimrc
ln -fs ~/.files/zshrc ~/.zshrc