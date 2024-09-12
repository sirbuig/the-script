#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# zsh
echo -e "${YELLOW}[zsh] Installing zsh...${NC}"
sudo apt install zsh -y

# oh-my-zsh
echo -e "${YELLOW}[oh-my-zsh] Installing oh-my-zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# don't forget
echo -e "${GREEN}zsh setup complete! For changes to take effect, you'll probably need to reboot!${NC}"