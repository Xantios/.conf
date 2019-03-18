#!/bin/bash
# Using bash just to check if ZSH is installed

#@TODO: Check enviroment

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

# Jump to home dir
cd

# Get oh-my-zsh up and running
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
mv .zshrc .zshrc.org

# Get Powerlevel 9K
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Get zsh-autosuggestions
git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Install syntax highlighter
brew install zsh-syntax-highlighting

# Get my confs
mv .conf .conf.bak
git clone https://github.com/Xantios/.conf.git

# Link stuff up :-)
ln -s .conf/.zshrc ./.zshrc

ln -s .conf/.vimrc ./.vimrc
ln -s .conf/.vim ./.vim

ln -s .conf/.tmux.conf ./.tmux.conf
