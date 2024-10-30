#!/bin/zsh

sudo apt update -y && sudo apt upgrade -y

# Remove previous Mesa PPAs
sudo apt install ppa-purge
sudo ppa-purge -d noble ppa:kisak/kisak-mesa

# Add Kisak Mesa PPA
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:kisak/kisak-mesa
sudo apt update -y

# Mesa Utilities
sudo apt install mesa-utils

# Additional Libraries
sudo add-apt-repository universe
sudo apt install build-essential libxmu-dev libxi-dev libgl-dev binutils
sudo apt install glew-utils libglew2.2 libglewmx-dev libglewmx1.13
sudo apt install freeglut3-dev freeglut3
sudo apt install mesa-common-dev
sudo apt-get install libglew-dev
sudo apt install libglm-dev

# SOIL
sudo apt-get install libsoil-dev

# Verify installation
# glxinfo | grep "OpenGL version"