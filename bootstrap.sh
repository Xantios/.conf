#!/bin/bash
# Using bash just to check if ZSH is installed

#@TODO: Check environment

# Check if ZSH is installed
if [ -z `which zsh` ]; then
	echo Please install ZSH first
	exit 1
fi

# Check if Git is installed
if [ -z `which git` ]; then
	echo Please install Git first
	exit 1
fi

if [ $(uname) == "Darwin" ]; then
	if [ -z `which brew` ]; then
		echo Please install Brew first
	fi
fi

# Jump to home dir
cd

# Get oh-my-zsh up and running
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get Meslo Slashed font for powerline
# curl -L https://github.com/powerline/fonts/raw/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf --output ~/Library/Fonts/MesloSlashedRegularForPowerline.ttf

# Install Melso font
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip --output ~/Library/Fonts/meslo.zip
cd ~/Library/Fonts && unzip meslo.zip

# Get zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.conf/custom/zsh-autosuggestions

# Get zsh-nvm plugin
# git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Mac installer 
if [ $(uname) == "Darwin" ]; then
	# Install oh-my-posh
	brew install jandedobbeleer/oh-my-posh/oh-my-posh

	# Install syntax highlighter
	brew install zsh-syntax-highlighting

	# And autosuggestions
	brew install zsh-autosuggestions
fi

# Generate docker completion
docker completion zsh > $HOME/.conf/docker-completion.sh

# Get my confs
mv .conf .conf.bak
git clone https://github.com/Xantios/.conf.git

# Link stuff up :-)
ln -s .conf/.zshrc ./.zshrc
ln -s .conf/.vimrc ./.vimrc
ln -s .conf/.vim ./.vim
ln -s .conf/.tmux.conf ./.tmux.conf
