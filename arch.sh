#!/bin/bash
#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

~/.files/update.sh
#Installs archiving/compreshion Pacages
sudo pacman -S --needed p7zip unrar tar rsync zstd 
#Installs basic pacages
sudo pacman -S --needed base-devel curl wget nano neovim firefox vlc
#Nemo and extentions
sudo pacman -S --needed nemo nemo-fileroller nemo-image-converter nemo-preview nemo-seahorse nemo-share nemo-terminal nemo-python


#Installs microcode Based on cpu
if [[ $(lscpu) == *AMD* ]]; then
 sudo pacman -S amd-ucode
elif [[ $(lscpu) == *intel* ]]; then
 sudo pacman -S intel-ucode
 sudo pacman -S mesa
fi

#Installs xorg and nvida driver if needed
if [[ $Video == Y ]]; then
 sudo pacman -S xorg-server
	if [[ $(lspci) == *NVIDIA* ]]; then
 sudo pacman -S nvidia nvidia-utils
	fi
fi

#Installs and enables gui
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
systemctl enable lightdm

#Installs yay
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

#installs genral pacages
yay -S --needed spotify bat network-manager-applet
#installs fonts
yay -S --needed adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gsfonts nerd-fonts-complete noto-fonts-cjk otf-font-awesome ttf-font-awesome ttf-ms-fonts ttf-font-awesome ttf-liberation ttf-ms-fonts ttf-opensans

#Installs discord and stuff for virtual camra
discord
yay -S discord obs-studio v4l2loopback-dkms

if [[ $1 == gaming ]]; then
	#Installs gaming resorces
	yay -S --needed wine lutris steam minecraft-launcher jdk
fi

#Sets up an ansible user
if [[ $1 == ansible ]]; then
	sudo groupadd -g 200 ansible
	sudo useradd -m -u 200 -g ansible -G users -G wheel ansible
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZry9qcc9nnGZSA/CO1rHJjUl76oW+VSWMdn2TfkxfS Ansible" > /tmp/authorized_keys
	sudo mkdir /home/ansible/.ssh/
	sudo mv /tmp/authorized_keys /home/ansible/.ssh/authorized_keys
	sudo chown ansible:ansible -R /home/ansible/
fi

#Installs zsh
sudo pacman -S --needed zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Links zsh and vim rc files
ln -fs ~/.files/vimrc ~/.vimrc
ln -fs ~/.files/zshrc ~/.zshrc
