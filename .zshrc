# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="af-magic"
ZSH_THEME="powerlevel9k/powerlevel9k"

# 9k specific mods
. $HOME/.conf/.powerlevel

# Disable auto-update?
DISABLE_AUTO_UPDATE="false"

# Dont ask me just update....
DISABLE_UPDATE_PROMPT=true

# The "Did you mean $this" function is really annoying, lets hack it out
unsetopt correct_all
unsetopt correct
ENABLE_CORRECTION="false"

# Pull in some plugins
plugins=(git docker sudo zsh-autosuggestions)

# We need to set editor because we depend on it in the next blocks
export EDITOR='vim'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
#export LANG=C

# I know my own hostname
DEFAULT_USER=`whoami`

##########################################################
# Export paths 
##########################################################
export PATH=$PATH:~/.composer/vendor/bin # Composer

export PATH=$PATH:/usr/local/mysql/bin # MySQL
# export PATH=$PATH:~/.android/dev/ # Android Dev kit

PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH" # Add for inetutils (ftp, telnet in OS  (brew install inetutils)) 

##########################################################
# Aliases 
##########################################################
alias cda="composer dumpautoload" 
alias art="php artisan "
#alias php55="/Applications/MAMP/bin/php/php5.5.38/bin/php"

alias dnsreset="sudo killall -HUP mDNSResponder" # Reload DNS on a Mac

alias rehash='. ~/.zshrc' # Reload ZSH

#alias zshconf='$EDITOR ~/.zshrc' # Edit zshrc
#alias vimconf='$EDITOR ~/.vimrc' # edit vimrc

alias tmp="cd ~/temp" # I just use a temp dir to dump stuff in my home folder 
alias notes="cd ~/notes" # I really should find a notes app i like one of these days. 

#alias serve="ionic serve -csab" # Ionic server
#alias ionx="open ./platforms/ios/*.xcodeproj" # Open current ionic project in xCode 

alias vihost='sudo vi /etc/hosts' 

# /usr/local/bin/pstorm
alias storm="pstorm ."  # Open current folder in php storm
alias s="pstorm ."  # Open current folder in php storm

alias proj=projfunc
alias pwgen=pass # or just use pass 

#alias dokku='bash $HOME/.dokku/contrib/dokku_client.sh'
#alias redis="redis-server /usr/local/etc/redis.conf"

alias dockerize="~/Projects/current/dockerize/bin/console dockerize"
alias de="docker exec -ti "
alias enter="~/enter"

alias dockly="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly"

# Source the init to start oh-my-zsh on spin-up
source $ZSH/oh-my-zsh.sh

# If you have .zshrc.local file we source it so you can put some passwords in enviroment 
# or do some local addons if needed
if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

##########################################################
# Export some tokens and vars
##########################################################

# NPM
if [ -f ~/.npmrc ]; then
    export NPM_TOKEN=`cat ~/.npmrc  | cut -d= -f2`
fi

# NVM 
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

vihomestead() {
    vi $HOME/.homestead/homestead.yaml
    cd $HOME/Homestead ; vagrant provision
}

func projfunc() {
    cd ~/Projects/current/$@
    #cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Projects/$@
}

# Just a quick and dirty overview of running virtualmachines 
func vblist()
{
    ALL=`VBoxManage list vms | cut -d{ -f1 | tr -d '"'`
    RUNNING=`VBoxManage list runningvms | cut -d{ -f1 | tr -d '"'`
    TOTAL=`echo $ALL | wc -l | tr -d "[:space:]" | tr -d "\n"`
    RUN=`echo $RUNNING | wc -l | tr -d "[:space:]" | tr -d "\n"`

    echo --- Registered VMs \(${TOTAL}\)
    echo
    echo $ALL
    echo
    echo --- Running VMs \($RUN\)
    echo
    echo $RUNNING
    echo
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

# As a final touch
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
