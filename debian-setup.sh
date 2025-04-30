#!/bin/bash

scriptstarttime=$(date)

#
################################################################################################################################################
#                                   Use the curl command below to start the script
# 
#  bash <(curl --silent https://raw.githubusercontent.com/robertstrom/debian-kde-build/refs/heads/main/debian-setup.sh) | tee kali-install-script.log
#
#
################################################################################################################################################

# Setting hostname
read -p "What is the hostname of this machine? " sethostname
sudo hostnamectl set-hostname $sethostname
# Fixing the hostname in the /etc/hostname file - uses the variable set above when setting the hostname
getprevhostname=$(grep 127.0.1.1 /etc/hosts | awk '{ print $2 }')
sudo  sed -i "s/$getprevhostname/$sethostname/" /etc/hosts

touch ~/.screenrc
echo "# Enable mouse scrolling and scroll bar history scrolling" > ~/.screenrc
echo "termcapinfo xterm* ti@:te@" >> ~/.screenrc

# Create directory for sshfs mount for QNAP NAS
mkdir -p ~/QNAPMyDocs

mkdir -p /home/rstrom/.local/bin/

# Create a directory for mounting remote SMB shares
mkdir ~/SMBmount

# Create a working directory for temp type actions
mkdir ~/working


## Create a directory for copying down prebuilt Docker Images from NAS
mkdir ~/Docker-Images

# Setup fuse group and add user to fuse group for sshfs use
sudo groupadd fuse
sudo usermod -a -G fuse rstrom

sudo DEBIAN_FRONTEND=noninteractive apt update && sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -yq


arch=$(uname -m)

case "$arch" in
  x86_64|amd64)
    sudo DEBIAN_FRONTEND=noninteractive apt install -yq shellcheck libimage-exiftool-perl pv terminator copyq xclip dolphin krusader \
    flameshot html2text csvkit remmina sipcalc \
    xsltproc rinetd torbrowser-launcher httptunnel tesseract-ocr ncdu grepcidr speedtest-cli sshuttle mpack filezilla lolcat \
    ripgrep bat dcfldd redis-tools jq keepassxc okular exfat-fuse exfatprogs xsel pandoc poppler-utils ffmpeg \
    zbar-tools gnupg2 dc3dd rlwrap fastfetch hyfetch lolcat 7zip-standalone eza docker.io docker-cli \
    code-oss obsidian trufflehog python3-trufflehogregexes golang-go ligolo-ng sublist3r tcpspy xrdp mono-complete
    ;;
  i?86)
    echo "Architecture: x86 (32-bit)"
    ;;
  arm*)
    echo "Architecture: ARM"
    ;;
  aarch64)
    echo "Architecture: AArch64 (64-bit ARM)"
    mkdir ~/Downloads
    sudo DEBIAN_FRONTEND=noninteractive apt install -yq shellcheck libimage-exiftool-perl pv terminator copyq xclip dolphin krusader kdiff3 krename kompare xxdiff krename kde-spectacle \
    flameshot html2text csvkit remmina kali-wallpapers-all hollywood-activate kali-screensaver gridsite-clients sipcalc \
    xsltproc rinetd httptunnel kerberoast tesseract-ocr ncdu grepcidr speedtest-cli sshuttle mpack filezilla lolcat \
    ripgrep bat dcfldd redis-tools feroxbuster name-that-hash jq keepassxc okular exfat-fuse exfatprogs kate xsel pandoc poppler-utils ffmpeg \
    zbar-tools gnupg2 dc3dd rlwrap partitionmanager kali-undercover fastfetch hyfetch lolcat 7zip-standalone eza autorecon docker.io docker-cli \
    code-oss obsidian breeze-icon-theme trufflehog python3-trufflehogregexes coercer golang-go ligolo-ng sublist3r tcpspy xrdp libraspberrypi-bin
    ;;
  ppc64le)
    echo "Architecture: PowerPC 64-bit Little Endian"
    ;;
  *)
    echo "Architecture: Unknown ($arch)"
    ;;
esac


# Enable the docker service
sudo systemctl enable docker --now

## Enable the xrdp service
sudo systemctl enable xrdp --now

# Add the currenbt user to the docker group so that you don't need to use sudo to run docker commands
sudo usermod -aG docker $USER

# Install docker compose

## One way of getting the current version information from GitHub
## curl -Ls https://api.github.com/repos/docker/compose/releases/latest | jq -r ".assets[].browser_download_url" | grep -v '\.json\|\.sha256'

## An alternate way of getting the current version information from GitHub
## curl -Ls https://api.github.com/repos/docker/compose/releases/latest | grep browser_download | egrep linux-aarch64\"$ | awk -F"\""  '{ print $4 }'

dockercomposelatestamd64=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".assets[].browser_download_url" | grep docker-compose-linux-x86_64$)
dockercomposelatestaarch64=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".assets[].browser_download_url" | grep docker-compose-linux-aarch64$)
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins

case "$arch" in
  x86_64|amd64)
    echo "Architecture: x86-64 (64-bit)"
    wget $dockercomposelatestamd64 -O $DOCKER_CONFIG/cli-plugins/docker-compose
    ;;
  i?86)
    echo "Architecture: x86 (32-bit)"
    ;;
  arm*)
    echo "Architecture: ARM"
    ;;
  aarch64)
    echo "Architecture: AArch64 (64-bit ARM)"
    wget $dockercomposelatestaarch64 -O $DOCKER_CONFIG/cli-plugins/docker-compose
    ;;
  ppc64le)
    echo "Architecture: PowerPC 64-bit Little Endian"
    ;;
  *)
    echo "Architecture: Unknown ($arch)"
    ;;
esac

chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Download and Install Vivaldi
curl -s https://vivaldi.com/download/ | grep -oP 'https://[^"]+amd64\.deb' | xargs wget
VIVALDI=$(ls vivaldi-stable*.deb)
sudo dpkg -i $VIVALDI

# Install python virtual environments venv
pip install virtualenv

# pipx ensurepath
pipx ensurepath
## sudo pipx ensurepath --global # optional to allow pipx actions with --global argument

## 2024-11-09 - Added the install of 1password
pushd ~/Downloads

case "$arch" in
  x86_64|amd64)
    echo "Architecture: x86-64 (64-bit)"
    wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
    sudo dpkg -i 1password-latest.deb
    ;;
  i?86)
    echo "Architecture: x86 (32-bit)"
    ;;
  arm*)
    echo "Architecture: ARM"
    ;;
  aarch64)
    ## https://support.1password.com/install-linux/#arm-or-other-distributions-targz
    echo "Architecture: AArch64 (64-bit ARM)"
    curl -sSO https://downloads.1password.com/linux/tar/stable/aarch64/1password-latest.tar.gz
    sudo tar -xf 1password-latest.tar.gz
    sudo mkdir -p /opt/1Password
    sudo mv 1password-*/* /opt/1Password
    sudo /opt/1Password/after-install.sh
    rm -rf 1password*
    ;;
  ppc64le)
    echo "Architecture: PowerPC 64-bit Little Endian"
    ;;
  *)
    echo "Architecture: Unknown ($arch)"
    ;;
esac
popd

# Download and Install CopyQ
copyqdownload=$(curl -s https://api.github.com/repos/hluk/CopyQ/releases/latest | jq -r ".assets[].browser_download_url" | grep Debian_12)
wget $copyqdownload -O ~/Downloads/copyq-amd64.deb
sudo dpkg -i ~/Downloads/copyq-amd64.deb

# Download the com.github.hluk.copyq.desktop file from GitHub and copy it to the ~/.config/autostart/com.github.hluk.copyq.desktop file so that CopyQ will autostart on login
mkdir -p ~/.config/autostart/
wget https://raw.githubusercontent.com/robertstrom/debian-kde-build/refs/heads/main/com.github.hluk.copyq.desktop -O ~/.config/autostart/com.github.hluk.copyq.desktop
chmod 600 ~/.config/autostart/com.github.hluk.copyq.desktop

# Install glow terminal markdown renderer
# https://github.com/charmbracelet/glow?tab=readme-ov-file
go install github.com/charmbracelet/glow@latest

# Install the Microsoft markitdown Markdown converter
git clone https://github.com/microsoft/markitdown.git
cd markitdown
docker build -t markitdown:latest .

# Install wwwtree
sudo git clone https://github.com/t3l3machus/wwwtree /opt/wwwtree
cd /opt/wwwtree
sudo pip3 install -r requirements.txt
sudo chmod +x wwwtree.py
cd /usr/bin
sudo ln -s /opt/wwwtree/wwwtree.py wwwtree

# Change shell to zsh
chsh -s /bin/zsh

scriptendtime=$(date)
echo " "
echo "The script started at $scriptstarttime"
echo " "
echo "The script completed at $scriptendtime"
echo " "
echo "The installation and configuration of this new Kali build has completed"
