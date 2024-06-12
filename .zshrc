# Load oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.conf/posh.yml)"

# Plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load fzf 
eval "$(fzf --zsh)"

# Install plugins
# light is alias for load without debug symbols
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Use Oh-my-zsh plugins
zinit snippet OMZP::git

# Disable auto-update?
DISABLE_AUTO_UPDATE="false"

# Dont ask me just update....
DISABLE_UPDATE_PROMPT=true

# The "Did you mean <whatever>" function is really annoying, lets hack it out
unsetopt correct_all
unsetopt correct
ENABLE_CORRECTION="false"

# Load docker completion
autoload -Uz compinit && compinit
source $HOME/.conf/docker-completion.sh

# Git set global ignore
git config --global core.excludesFile '~/.conf/.gitignore'

# Docker has some stacking options
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# We need to set editor because we depend on it in the next blocks
export EDITOR='nvim'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
#export LANG=C

# Pull current user to var
DEFAULT_USER=`whoami`

# Dokku conf
export DOKKU_HOST=molly
export DOKKU_PORT=22

# Set LS colors 
export CLICOLOR=1

# Lest stop wasting metirc tons of time 
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

##########################################################
# Export paths 
##########################################################
export PATH=$PATH:~/.composer/vendor/bin    # Composer
export PATH=$PATH:/usr/local/opt/inetutils/libexec/gnubin # inet-utils (brew install inetutils)
export PATH=$PATH:/usr/local/go/bin # Go
export PATH=$PATH:~/go/bin # Go packages
export PATH=$PATH:~/bin/ # bin folder in home 
export PATH=/opt/homebrew/bin:$PATH # New homebrew (on M1)
export PATH=/Applications/GoLand.app/Contents/MacOS:$PATH # Goland
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/
export PATH=$PATH:/opt/homebrew/Cellar/qemu/8.2.0/bin
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
alias vim=nvim

# Android hacking 
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"

# Docker stuff
# I do to much docker stuff, so please checkout github.com/xantios/ for docker related stuff

# alias dockerize="~/Projects/current/dockerize/bin/console dockerize"
# alias enter="php ~/enter.php $@" # Moved to a seperate repo, see github.com/xantios/docker-helper

# replace by php script
alias dps="php ~/.conf/dps.php"

alias dpr="dps | grep -i running"
alias des="docker exec -ti "
alias dl="docker logs -f "
alias docker-compose="echo FOEIKO!"

# Fix for alacritty not being supported on (most?) linux
alias ssh="TERM=xterm-256color $(which ssh)"

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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
