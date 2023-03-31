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

if [ -z `which brew` ]; then
	echo Please install Brew first
fi

# Jump to home dir
cd

# Get oh-my-zsh up and running
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Get Meslo Slashed font for powerline
curl -L https://github.com/powerline/fonts/raw/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf --output ~/Library/Fonts/MesloSlashedRegularForPowerline.ttf

# Get Powerlevel 10k
git clone  --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Get zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Get zsh-nvm plugin
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Install syntax highlighter
brew install zsh-syntax-highlighting

# And autosuggestions
brew install zsh-autosuggestions

# Get my confs
mv .conf .conf.bak
git clone https://github.com/Xantios/.conf.git

# Link stuff up :-)
ln -s .conf/.zshrc ./.zshrc
ln -s .conf/.vimrc ./.vimrc
ln -s .conf/.vim ./.vim
ln -s .conf/.tmux.conf ./.tmux.conf
