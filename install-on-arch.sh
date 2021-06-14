#!/bin/env bash

set -e
clear

if ! command -v pacman &> /dev/null
then
	echo "You are not running Arch, check for another installation script or request for a new one (feel free to contribute with a new one aswell)"
    exit
fi

# Packages
QTILE(){
	paru --noconfirm -S xorg qtile kitty psuinfo tint2 picom-jonaburg-git firefox neofetch pavucontrol ttf-font-awesome terminus-font zsh neovim cmus ranger clyrics lsd doas doas-sudo rofi rofi-dmenu redshift bat wmctrl feh nitrogen >/dev/null 2&>1 
	cp dotfiles/config $HOME/.config;
	cp dotfiles/.vimrc $HOME/.vimrc
	cp -r dotfiles/.oh-my-zsh/ $HOME/.oh-my-zsh
	cp -r dotfiles/bin $HOME/bin
	cp dotfiles/.zshrc $HOME/.zshrc
	cp -r dotfiles/Pictures/Wallpapers $HOME/Pictures/Wallpapers
}

# Colors

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
END="\e[0m"

# Welcome
echo -e "${RED}Welcome!${END}"
echo -e "${GREEN}This is the automated installer for my dotfiles${END}" 
echo ""
echo -e "${YELLOW}Thanks for downloading! - LGroos${END}"
echo ""
read -p "Press enter to continue"

#Information

clear

echo -e "${RED}This is script will:${END}"
echo ""
echo -e "- ${YELLOW}Update your system${END}"
echo -e "- ${YELLOW}Install necessary packages${END}"
echo -e "- ${YELOOW}Enable the Chaotic-AUR repository${END}"
echo -e "- ${YELLOW}Clone the repository to your current folder${END}"
echo -e "- ${YELLOW}Copy configuration files to it's place (and delete your previous on the process)${END}"
echo ""
read -p "Press enter if you want to continue"

clear

#Installation

echo "Enabling Chaotic-AUR"
sudo pacman-key --recv-key 3056513887B78AEB >/dev/null 2>&1
sudo pacman-key --lsign-key 3056513887B78AEB >/dev/null 2>&1
sudo pacman --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst' >/dev/null 2>&1
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf
sudo pacman --noconfirm -Syy >/dev/null 2>&1
echo "Done"
echo"==========================================="

echo "Cloning the repository"
git clone https://github.com/GroosL/dotfiles/ > /dev/null 2>&1
echo "Done"
echo "=========================================="

echo "Installing packages"
sudo pacman --noconfirm -S paru >/dev/null 2>&1

PS3='Please enter your Window Manager: '
options=("Qtile" "I3" "Quit")                    
select opt in "${options[@]}"
do
    case $opt in
        "Qtile")
            QTILE;
            ;;
        "I3")
            I3;
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
echo "Done"
echo "=========================================="

clear

echo -e "${RED}This is the first version of this installer, I'll be updating it in the next few days. Feel free to help${END}"
echo ""
echo -e "${RED}Things to add:${END}"
echo -e "- ${YELLOW}Backups before installing${END}"
echo -e "- ${YELLOW}Copy configuration files according to user's choice${END}"
echo -e "- ${YELLOW}Add more Window Manager options${END}"
echo ""
echo -e "${GREEN}Thanks for using this installer and for using my dotfiles - LGroos${END}"
