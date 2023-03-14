if [[ ! -e ~/.bash-git-prompt ]]; then
	echo "Installing bash-git-prompt"
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

if [[ ! -e ~/.nvm ]]; then
	echo "Installing NVM"
	export NVM_DIR="$HOME/.nvm" && (
		git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
		cd "$NVM_DIR"
		git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	) && . "$NVM_DIR/nvm.sh"
	# Remove content starting at "#nvm-start" and ending at "#nvm-end" comments.
	sed -i '/#nvm-start/,/#nvm-end/d' ~/.bashrc
	cat <<-'EOF' >> ~/.bashrc
	#nvm-start
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	#nvm-end
EOF
fi

if ! type csharprepl > /dev/null; then
	echo "Installing csharprepl"
	if ! type dotnet > /dev/null; then
		echo "ERROR: dotnet command not installed"
	else
		dotnet tool install -g csharprepl
	fi
fi

export DEV_ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install packages. Skip install using the -s option.
if [[ $1 == -s ]]; then
	shift
else
	$DEV_ENV_DIR/scripts/install-packages.sh
fi

# Install gnome scripts (added to right-click menu on files)
echo "Installing gnome scripts"
NAUTILUS_SCRIPT_DIR="/home/$USER/.local/share/nautilus/scripts"
echo "   => $NAUTILUS_SCRIPT_DIR"
mkdir -p "$NAUTILUS_SCRIPT_DIR"
chmod +x ./scripts/nautilus-scripts/*
cp -f ./scripts/nautilus-scripts/* "$NAUTILUS_SCRIPT_DIR/"
# cp -f "$DEV_ENV_DIR"/scripts/nautilus-scripts/* "${NAUTILUS_SCRIPT_DIR}/"

# Show seconds on system clock.
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Set autoSetupRemote to true so that new branches can be pushed with just git push
# instead of git push -u
git config --global push.autoSetupRemote true

# Remove content starting at "#geo-cli-start" and ending
# at "#geo-cli-end" comments.
sed -i '/#dev-env-config-start/,/#dev-env-config-end/d' ~/.bashrc

# if [[ -n `grep dev-env-config ~/.bashrc` ]]; then

#	tee -a $HOME/.bashrc <<- EOF
	cat <<- EOF >> $HOME/.bashrc
	
	#dev-env-config-start
	# Dev environment config repo bootstrap
	#######################################
	. "$DEV_ENV_DIR/bashrc.sh"
	#######################################
	#dev-env-config-end
EOF

# Set VSCode as the default editor for text files.
bash xdg-mime default code.desktop text/plain
# Changes will take effect after a reboot/re-log
defaults_file=/usr/share/applications/defaults.list
sudo sed 's_text/xml=org.gnome.gedit.desktop;google-chrome.desktop_text/xml=code.desktop_g' $defaults_file
sudo sed 's_text/html=firefox.desktop;google-chrome.desktop_text/html=code.desktop_g' $defaults_file
sudo sed 's_org.gnome.gedit.desktop_code.desktop_g' $defaults_file

# Install Peek screen to gif recorder.
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek

# Set default sort order for files in explorer.
gsettings set org.gnome.nautilus.preferences default-sort-order 'mtime'
gsettings set org.gnome.nautilus.preferences default-sort-in-reverse-order true

# fi

# if [[ ! -f $DEV_ENV_DIR/include/gitlab/gitlab-pat ]]; then
# 	cp $DEV_ENV_DIR/include/gitlab/gitlab-pat-example $DEV_ENV_DIR/include/gitlab/gitlab-pat
# 	echo
# 	echo "Add gitlab PAT to $DEV_ENV_DIR/include/gitlab/gitlab-pat"
# 	echo
# fi

# Re-source .bashrc
. ~/.bashrc

echo Done