git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1


# Remove content starting at "#geo-cli-start" and ending
# at "#geo-cli-end" comments.
sed -i '/#dev-env-config-start/,/#dev-env-config-end/d' ~/.bashrc

# if [[ -n `grep dev-env-config ~/.bashrc` ]]; then

#	tee -a $HOME/.bashrc <<- EOF
	cat <<- EOF >> $HOME/.bashrc
	
	#dev-env-config-start
	# Dev environment config repo bootstrap
	#######################################
	. ~/dev-env-config/bashrc.sh
	#######################################
	#dev-env-config-end
	EOF
# fi
