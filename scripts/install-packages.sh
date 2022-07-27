add_ppa() {
  grep -h "^deb.*$1" /etc/apt/sources.list.d/* > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "Adding ppa:$1"
    sudo add-apt-repository -y ppa:$1
    return 0
  fi

  echo "ppa:$1 already exists"
  return 1
}

# Add OBS repository
add_ppa -y ppa:obsproject/obs-studio
# Add CopyQ repository
add_ppa -y ppa:hluk/copyq
# Add remmina repository
add_ppa -y ppa:remmina-ppa-team/remmina-next

sudo apt update -y

# Install OBS
sudo apt install -y obs-studio

# Install CopyQ
sudo apt install -y copyq

# Install Remmina
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret

# Install other packages
sudo apt-get install -y \
    vlc \
    xclip \
    rename