# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Fallback in case you dont need p10k
#ZSH_THEME="af-magic" 

# Full fancy
ZSH_THEME=powerlevel10k/powerlevel10k

# 10k specific mods / settings
. $HOME/.conf/.powerlevel

# Disable auto-update?
DISABLE_AUTO_UPDATE="false"

# Dont ask me just update....
DISABLE_UPDATE_PROMPT=true

# The "Did you mean <whatever>" function is really annoying, lets hack it out
unsetopt correct_all
unsetopt correct
ENABLE_CORRECTION="false"

# Permission checking is broken and then some. 
# Remove this when the permission checks are fixed
ZSH_DISABLE_COMPFIX=true

# NVM is a nice tool, but it slows down loading of the shell by 500ms+
# We can however lazy load it instad of eager loading
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Pull in some plugins
plugins=(git docker zsh-nvm zsh-autosuggestions)

# Git set global ignore
git config --global core.excludesFile '~/.conf/.gitignore'

# Docker Plugin has some stacking options
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Add zsh-autosuggestions to plugins array should work, if you run in to problems ref it directly
# . /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# We need to set editor because we depend on it in the next blocks
export EDITOR='vim'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
#export LANG=C

# Pull current user to var
DEFAULT_USER=`whoami`

# Dokku conf
export DOKKU_HOST=molly
export DOKKU_PORT=22

##########################################################
# Export paths 
##########################################################
export PATH=$PATH:~/.composer/vendor/bin    # Composer
export PATH=$PATH:/usr/local/opt/inetutils/libexec/gnubin # inet-utils (brew install inetutils)
export PATH=$PATH:/usr/local/go/bin # Go
export PATH=$PATH:~/go/bin # Go packages
export PATH=/opt/homebrew/bin:$PATH # New homebrew (on M1)
export PATH=/Applications/GoLand.app/Contents/MacOS:$PATH # Goland
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/

# pkg-conf
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/Cellar/ffmpeg/4.3.1-with-options_6/lib/pkgconfig

##########################################################
# Aliases 
##########################################################

# Go dev stuff
alias gadget="go vet ./... ; gofumpt -w -l ." 

# PHP Dev stuff
alias cda="composer dumpautoload" 
alias art="php artisan "
alias sart="sail artisan "
alias storm="phpstorm ."  # Open current folder in php storm
alias pstorm="phpstorm " # musle memmory
alias sail="./vendor/bin/sail "

# General Dev stuff ( General Dev-stuff , Salutes ! )
alias tmp="cd ~/temp" # I just use a temp dir to dump stuff in my home folder 
alias notes="cd ~/notes" # I really should find a notes app i like one of these days. 

# Redis
alias redis="redis-server ~/.conf/.redis.conf"

# MacOS being a dick
alias dnsreset="sudo killall -HUP mDNSResponder" # Reload DNS on a Mac
alias screenshotdir="defaults write com.apple.screencapture location /${HOME}/screenshots"

# Shell hacking stuff
#alias rehash='. ~/.zshrc' # Reload ZSH
alias rehash="exec zsh" # session fix

alias zshconf='$EDITOR ~/.zshrc' # Edit zshrc
alias vimconf='$EDITOR ~/.vimrc' # Edit vimrc
alias vihost='sudo vi /etc/hosts' # Edit hostfile

alias proj=projfunc

# I do to much docker stuff, so please checkout github.com/xantios/ for docker related stuff

# alias dockerize="~/Projects/current/dockerize/bin/console dockerize"
# alias enter="php ~/enter.php $@" # Moved to a seperate repo, see github.com/xantios/docker-helper

# replace by php script
# alias dps="docker ps -a --format \"{{.ID}}\t{{.State}}\t{{.Status}}\t\t\t{{.Names}}\""
alias dps="php ~/.conf/dps.php"

alias dpr="dps | grep -i running"
alias des="docker exec -ti "
alias dl="docker logs -f "
alias docker-compose="echo FOEIKO!"
# Source the init to start oh-my-zsh on spin-up
source $ZSH/oh-my-zsh.sh

# If you have .zshrc.local file we source it so you can put some passwords in enviroment 
# or do some local addons if needed
if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

# Alt path
if [ -f $HOME/.conf/.zshrc.local ]; then
    source $HOME/.conf/.zshrc.local
fi

# My terminal is dark! 
alias hon="hue lights all on ; hue lights all \=100%"
alias hoff="hue lights all \=0%"

##########################################################
# Export some tokens and vars
##########################################################

# NPM
if [ -f ~/.npmrc ]; then
    export NPM_TOKEN=`cat ~/.npmrc  | cut -d= -f2`
fi

# NVM 
export NVM_DIR="$HOME/.nvm"

## Some small functions, you can call them just like any regular bash/zsh command
## eg: pass <enter> will give a random password

# Little benchmark function
func bench() {
    shell=${1-$SHELL}
    for  i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

func projfunc() {
    cd ~/Projects/$@
}

# Show hidden files
func showhidden()
{
    defaults write com.apple.finder AppleShowAllFiles TRUE
    echo killall Finder
}

# Hide hidden files
func hidehidden()
{
    defaults write com.apple.finder AppleShowAllFiles FALSE
    echo killall Finder
    
}

# Generate a random pass
func pass() {
    openssl rand -base64 24 | cut -d= -f1
}

# Get LAN ip
func lan() {
    ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'
}

# Get WAN ip
func wan() {
    curl http://icanhazip.com
}
