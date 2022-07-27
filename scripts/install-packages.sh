# Add OBS repository
sudo add-apt-repository ppa:obsproject/obs-studio
# Add CopyQ repository
sudo add-apt-repository ppa:hluk/copyq
# Add remmina repository
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next

sudo apt update

# Install OBS
# sudo apt install -y obs-studio

# Install CopyQ
# sudo apt install -y copyq

# Install Remmina
# sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret

# Install other packages
sudo apt install -y \
    obs-studio \
    copyq \
    remmina remmina-plugin-rdp remmina-plugin-secret \
    vlc \
    xcopy \
    rename