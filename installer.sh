#!/bin/bash
set -e
clear
sudo apt update
echo "installing apt packages..."
sudo apt install -y curl blobby flatpak git gnome-shell-extension-manager gnome-shell-extensions gnome-software gnome-tweaks gufw inkscape kdeconnect libcanberra-gtk micro neofetch vlc wireplumber
echo "finished installing apt packages"
sleep 1
clear
echo "downloading and installing .deb packages (steam; vs-code)..."
wget vs-code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'   
wget steam_latest.deb 'https://cdn.fastly.steamstatic.com/client/installer/steam.deb'
sudo apt install ./vs-code.deb -y 
sudo apt install ./steam_latest.deb -y
echo "finished installing .deb packages"
sleep 1
clear
echo "installing snap packages (discord)..."
sudo snap install discord
echo "finished installing snap packages"
sleep 1
clear 
echo "installing flathub and related packages..."
flatpak install flathub
flatpak install flathub org.audacityteam.Audacity
flatpak install flathub org.prismlauncher.PrismLauncher
echo "finished installing flathub and related packages"
sleep 1
clear
echo "installing packages that require curl for installation... (github cli (gh); brave (brave-browser))"
curl -fsS https://dl.brave.com/install.sh | sh
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
echo "brave and github cli installed"
echo -n "Do you want to sign in to github cli now? (y/n): "
read VAR1
if [[ $VAR1 == "y" ]]; then
	gh auth login
elif [[ $VAR1 == "n" ]]; then
	echo "Ok, if you want to do it later use 'gh auth login' in the terminal to sign in."
else
	echo -e "\033[0;31m VariableError: ${VAR1} is not a valid answer! \033[0m"
	echo -e "\033[0;31m exited with code 1 \033[0m"
	exit 1
fi
