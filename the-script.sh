#!/bin/bash

# OS name
os=$(uname)

# Check if it's a Linux machine
if [ "$os" = "Linux" ]; then

echo "This is a Linux machine"

    # Check if it's debian-based
    if [[ -f /etc/debian_version ]]; then
        echo "It's ok, it's debian-based"
    else
        echo "The script is not configured for other pkg managers yet"
        exit 1
    fi

else
    echo "This is not a Linux machine, we don't do that here"
    exit 1
fi

# Update and upgrade the system
sudo apt update -y && sudo apt upgrade -y

# build-essential
echo "Installing build-essential..."
sudo apt install build-essential -y

# Python
echo "Installing Python stuff..."
sudo apt install python3 python3-pip python-is-python3 -y

# Git
echo "Installing Git..."
sudo apt install git -y

# Github ssh key commands
echo "Setting up Github ssh key (don't forget to add them to your account)..."

echo "First you must configure git config..."
echo "What is your email?"
read github_email
echo "What is your username?"
read github_username

git config --global user.name $github_username
git config --global user.email $github_email

ssh-keygen -t ed25519 -C $github_email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

while true; do
    echo "Did you copy the key to your account?"
    read answer

    if [ "$answer" = "yes" ]; then
        echo "Github ssh key configuration completed!"
        break
    else
        echo "What's taking you so long? Hurry up!"
    fi
done

# Fira Code font
echo "Installing Fira Code font..."

sudo apt install fonts-firacode -y