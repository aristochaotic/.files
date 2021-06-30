#!/bin/bash

while :; do
		case $1 in
				-al|--alice) Alice="True"
				;;
				-a|--ansible) Ansible="True"
				;;
				-l|--livepatch) Livepatch="True"
				;;
				*) break
		esac
		shift
done

#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

~/.files/update.sh
#Installs basic pacages
sudo apt install curl wget nano neovim smartmontools

echo "#Bob
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG50sgvTSDclHBXiGljCwo9NWfM411U6f12Xog0nt6Bw BOB
#Laptop
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECmmIxbghuZNKUCHwqkml5zKIxC8f4SZP+Vm1JIYAOL Laptop
#Vcode
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID0J5BnE39FsLimpAAvbrZI4xfGM5Si0UOpTsDwOfITh Vcode
#Phone
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJDhddiEwi77eNYLYPJhfP/VZaUqezTNvxIwh0dV2SS JuiceSSH
" > ~/.ssh/authorized_keys


if [[ $Alice == True  ]]; then
	sudo groupadd alice
	sudo useradd -m -g alice -G users -G sudo alice
	sudo chsh -s /bin/zsh alice
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILWG3cIBju6vzX6s8JlmGNJOiWY7pQ19bHvcqDADtWzv snowi@DESKTOP-EVIR8IH" > /tmp/authorized_keys
	sudo mkdir /home/alice/.ssh/
	sudo mv /tmp/authorized_keys /home/alice/.ssh/authorized_keys
	sudo chown alice:alice -R /home/alice/
fi

#Sets up an ansible user
if [[ $Ansible == True  ]]; then
	sudo groupadd -g 200 ansible
	sudo useradd -m -u 200 -g ansible -G users -G sudo ansible
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZry9qcc9nnGZSA/CO1rHJjUl76oW+VSWMdn2TfkxfS Ansible" > /tmp/authorized_keys
	sudo mkdir /home/ansible/.ssh/
	sudo mv /tmp/authorized_keys /home/ansible/.ssh/authorized_keys
	sudo chown ansible:ansible -R /home/ansible/
fi

if [[ $Livepatch == True  ]]; then
	sudo snap install canonical-livepatch
	sudo canonical-livepatch enable "$2"
fi

#Installs zsh
sudo apt install zsh && chsh -s /bin/zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Links zsh and vim rc files
ln -fs ~/.files/vimrc ~/.vimrc
ln -fs ~/.files/zshrc ~/.zshrc

#Removes unneeded files
rm ~/.bash* ~/.zshrc.pre-oh-my-zsh
