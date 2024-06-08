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

# Install Melso font
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip --output ~/Library/Fonts/meslo.zip
cd ~/Library/Fonts && unzip meslo.zip

# Get zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.conf/custom/zsh-autosuggestions

# Mac installer 
if [ $(uname) == "Darwin" ]; then
	# Install oh-my-posh
	brew install jandedobbeleer/oh-my-posh/oh-my-posh

	# Install syntax highlighter
	brew install zsh-syntax-highlighting

	# And autosuggestions
	brew install zsh-autosuggestions
fi

# Unix installer
# TODO
#

# Install z-init plugin manager
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Generate docker completion
docker completion zsh > $HOME/.conf/docker-completion.sh

# Get my confs
mv .conf .conf.bak
git clone https://github.com/Xantios/.conf.git

# Install fzf
if [ $(uname) == "Darwin" ]; then
    brew install fzf
fi

if [ $(uname) == "Linux" ]; then
    if [ $(cat /etc/lsb-release | grep -i ID | cut -d= -f2) == "Ubuntu" ]; then
        apt install fzf
    fi

    if [ $(cat /etc/lsb-release | grep -i ID | cut -d= -f2) == "Debian" ]; then
        apt install fzf
    fi
fi

# Link stuff up :-)
ln -s .conf/.zshrc ./.zshrc
ln -s .conf/.vimrc ./.vimrc
ln -s .conf/.vim ./.vim
ln -s .conf/.tmux.conf ./.tmux.conf
