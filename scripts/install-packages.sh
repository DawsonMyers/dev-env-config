PPA_ADDED=0
UPDATED=false

add_ppa() {
  grep -h "^deb.*$1" /etc/apt/sources.list.d/* > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "Adding ppa:$1"
    sudo add-apt-repository -y ppa:$1
    ((PPA_ADDED++))
    return 0
  fi

  echo "ppa:$1 already exists"
  return 1
}

install_apt_package_if_missing() {
    [[ $UPDATED == false ]] && sudo apt-
    for pkg_name in $@; do
        ! type sudo &> /dev/null && sudo='' || sudo=sudo
        [[ -z $pkg_name ]] && warn 'No package name supplied' && return 1

        if ! dpkg -l $pkg_name &> /dev/null; then
            status "Installing missing package: $pkg_name"
            # Only update once.
            [[ $UPDATED == false ]] && sudo apt update -y && UPDATED=true
            $sudo apt install -y "$pkg_name"
        fi
    done
}

# Add OBS repository
add_ppa ppa:obsproject/obs-studio
# Add CopyQ repository
add_ppa ppa:hluk/copyq
# Add remmina repository
add_ppa ppa:remmina-ppa-team/remmina-next

# Install OBS
install_apt_package_if_missing obs-studio

# Install CopyQ
install_apt_package_if_missing copyq

# Install Remmina
install_apt_package_if_missing remmina remmina-plugin-rdp remmina-plugin-secret

# Install other packages
install_apt_package_if_missing \
    vlc \
    xclip \
    rename