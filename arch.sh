#!/bin/bash
while :; do
		case $1 in
				-a|--ansible) Ansible="True"
				;;
				-g|--gaming) Gaming="True"
				;;
				-s|--sweet) Sweet="True"
				;;
				-v|--video) Video="True"
				;;
				-b|--bluetooth) Bluetooth="True"
				;;
				*) break
		esac
		shift
done

#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

~/.files/update.sh
#Installs archiving/compression packages
sudo pacman -S --needed p7zip unrar tar rsync zstd 
#Installs basic packages
sudo pacman -S --needed base-devel curl wget nano neovim bat
#Installs File system utilities
sudo pacman -S --needed ntfs-3g nfs-utils
#Installs networking packages
sudo pacman -S --needed networkmanager-openvpn 


#Installs microcode Based on cpu
if [[ $(lscpu) == *AMD* ]]; then
 sudo pacman -S --needed amd-ucode
elif [[ $(lscpu) == *intel* ]]; then
 sudo pacman -S --needed intel-ucode mesa
fi

#Installs xorg and nvida driver if needed
if [[ $Video == True ]]; then
	sudo pacman -S --needed xorg-server
	if [[ $(lspci) == *NVIDIA* ]]; then
		sudo pacman -S --needed nvidia nvidia-utils
	fi
	#Installs basic gui packages
	sudo pacman -S --needed firefox vlc gparted network-manager-applet
	#Installs Nemo and extensions
	sudo pacman -S --needed nemo nemo-fileroller nemo-image-converter nemo-preview nemo-seahorse nemo-share nemo-terminal nemo-python
	#Installs audio packages
	sudo pacman -S --needed pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pavucontrol 
	#Installs and enables GUI
	sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
	systemctl enable lightdm
fi


#Installs and enables reflector 
sudo pacman -S --needed reflector
sudo systemctl enable reflector.service

#Installs yay
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

#installs general packages
yay -S --needed spotify 
#installs fonts
yay -S --needed adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gsfonts nerd-fonts-complete noto-fonts-cjk otf-font-awesome ttf-font-awesome ttf-ms-fonts ttf-font-awesome ttf-liberation ttf-ms-fonts ttf-opensans

#Installs communication packages
yay -S --needed signal-desktop discord obs-studio v4l2loopback-dkms

#Installs gaming packages
if [[ $Gaming == True ]]; then
	yay -S --needed wine lutris steam minecraft-launcher jdk
fi

#Installs and enables Bluetooth
if [[ $Bluetooth == True ]]; then
	yay -S --needed bluez bluez-utils blueman
	sudo systemctl enable bluetooth.service
fi

#Sets up an ansible user
if [[ $Ansible == True ]]; then
	sudo groupadd -g 200 ansible
	sudo useradd -m -u 200 -g ansible -G users -G wheel ansible
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZry9qcc9nnGZSA/CO1rHJjUl76oW+VSWMdn2TfkxfS Ansible" > /tmp/authorized_keys
	sudo mkdir /home/ansible/.ssh/
	sudo mv /tmp/authorized_keys /home/ansible/.ssh/authorized_keys
	sudo chown ansible:ansible -R /home/ansible/
fi

#Installs zsh
sudo pacman -S --needed zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Links zshrc and vimrc
ln -fs ~/.files/vimrc ~/.vimrc
ln -fs ~/.files/zshrc ~/.zshrc

if [[ $Sweet == True ]]; then
	mkdir ~/.icons
	mkdir ~/.theams
	git clone https://github.com/EliverLara/candy-icons.git ~/.icons/candy-icons
	git clone -b nova https://github.com/EliverLara/Sweet.git ~/.themes/Sweet-nova
	
	gtk-update-icon-cache ~/.icons/candy-icons 
	gsettings set org.gnome.desktop.interface gtk-theme "Sweet-nova"
	gsettings set org.gnome.desktop.wm.preferences theme "Sweet-nova"
fi
