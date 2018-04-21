# .conf
Just some config files for you happy linux hackers

Installation
--------

Copy/paste install :-)

``sh -c "$(wget https://raw.githubusercontent.com/xantios/.conf/master/bootstrap.sh -O -)"``

Dependencies
---------
- Zsh
- git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
- This font: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf
- git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
- brew install zsh-syntax-highlighting
- A terminal fetisj 


Shell config
---------

I like Zsh, so there only is a zshrc config file in this repo. 

Installation for mac: 
``brew install zsh``

Installation for Linux/Unix somehting like:
``apt-get install zsh`` ;
``yum install zsh`` ;
``pacman -S zsh``

Also, check out [https://github.com/robbyrussell/oh-my-zsh](Oh My Zsh) for some very clever extensions in ZSH that I use.

Misc
--------

Rest of configs should be pretty self explanatory 
(tmux uses <ctrl>-a instead of B, and vim uses , as leader )
