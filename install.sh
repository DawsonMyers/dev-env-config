if [[ ! -e ~/.bash-git-prompt ]]; then
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

export DEV_ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install packages. Skip install using the -s option.
if [[ $1 == -s ]]; then
	shift
else
	$DEV_ENV_DIR/scripts/install-packages.sh
fi

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
# fi

if [[ ! -f $DEV_ENV_DIR/include/gitlab/gitlab-pat ]]; then
	cp $DEV_ENV_DIR/include/gitlab/gitlab-pat-example $DEV_ENV_DIR/include/gitlab/gitlab-pat
	echo
	echo "Add gitlab PAT to $DEV_ENV_DIR/include/gitlab/gitlab-pat"
	echo
fi

# Re-source .bashrc
. ~/.bashrc

echo Done