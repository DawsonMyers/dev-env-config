git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1


if [[ -n `grep dev-env-config ~/.bashrc` ]]; then

#	tee -a $HOME/.bashrc <<- EOF
	cat <<- EOF >> $HOME/.bashrc
	
	# Dev environment config repo bootsrap
	#######################################
	. ~/dev-env-config/bashrc.sh
	#######################################
	EOF
fi
