#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Update and upgrade the system
echo -e "${YELLOW}[System] Updating and upgrading the system...${NC}"
sudo apt update -y && sudo apt upgrade -y

# Java
echo -e "${YELLOW}[Java] Installing Java 21...${NC}"
sudo apt install openjdk-21-jdk -y

# Java - check
echo -e "${YELLOW}[Java] Java version...${NC}"
java -version

echo -e "${YELLOW}[Java] Is the output correct for Java?${NC}"
read answer

if [ "$answer" = "yes" ]; then
    echo -e "${GREEN}[Java] Java installed!${NC}"
else
    echo -e "${RED}[Java] Java must be configured before installing Maven...${NC}"
    exit 1
fi

# Maven

# Download
echo -e "${YELLOW}[Maven] Downloading Maven...${NC}"
maven_link=https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
wget $maven_link -P /tmp

# Extract to /opt
echo -e "${YELLOW}[Maven] Extracting the installation file to the /opt directory...${NC}"
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt

# Create a symbolic link
echo -e "${YELLOW}[Maven] Creating a symbolic link leading to the installation directory...${NC}"
sudo ln -s /opt/apache-maven-3.9.8 /opt/maven

# Environment Variables
echo -e "${YELLOW}[Maven] Setting up Environment Variables...${NC}"
sudo bash -c 'cat << EOF > /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64
export M2_HOME=/opt/apache-maven-3.9.8
export MAVEN_HOME=/opt/apache-maven-3.9.8
export PATH=\${M2_HOME}/bin:\${PATH}
EOF'

echo -e "${YELLOW}[Maven] Making the script executable...${NC}"
sudo chmod +x /etc/profile.d/maven.sh

echo -e "${YELLOW}[Maven] Executing the script to set up the variables...${NC}"
source /etc/profile.d/maven.sh

# Add to ~/.bashrc
if ! grep -q '/etc/profile.d/maven.sh' "$HOME/.bashrc"; then
    echo -e "${YELLOW}[Maven] Adding source command to ~/.bashrc..."
    echo "source /etc/profile.d/maven.sh" >> "$HOME/.bashrc"
fi

# Maven - check
echo -e "${YELLOW}[Maven] Maven version...${NC}"
mvn -version

echo -e "${YELLOW}[Maven] Is the output correct for Maven?${NC}"
read answer

if [ "$answer" = "yes" ]; then
    echo -e "${GREEN}[Maven] Maven installed!${NC}"
else
    echo -e "${RED}[Maven] Good luck figuring out the problem...${NC}"
    exit 1
fi
