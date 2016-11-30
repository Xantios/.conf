# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Overload old versions of PHP 
export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Disable auto-update?
DISABLE_AUTO_UPDATE="false"
# Dont ask me just update....
DISABLE_UPDATE_PROMPT=true
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# The "Did you mean $this" function is really annoying, lets hack it out
unsetopt correct_all
unsetopt correct
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker nyan sudo)

# Composaaah
export PATH=$PATH:~/.composer/vendor/bin

alias cda="composer dumpautoload"

# MySQL utils etc are in my MAMP install
export PATH=$PATH:/Applications/MAMP/Library/bin

# Source the init to start oh-my-zsh on spin-up
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# ( Just use vim everywere )
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
#export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# For al you nodeJS hipsters out there
if [ -f ~/.npmrc ]; then
    export NPM_TOKEN=`cat ~/.npmrc  | cut -d= -f2`
fi

# And for NVM
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Homestead
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

vihomestead() {
    vi $HOME/.homestead/homestead.yaml
    cd $HOME/Homestead ; vagrant provision
}

# the tilde key on NL keyboards are hard to reach. wrap a alias arround to (re)load config 
alias rehash='. ~/.zshrc'

# And while were at it
alias zshconf='vim ~/.zshrc'
alias vimconf='vim ~/.vimrc'

# Shortcuts
alias tmp="cd ~/temp"
alias temp="cd ~/temp"

#alias proj="cd ~/Dropbox/Projects"
#alias proj="cd ~/Projects"

alias proj=projfunc
func projfunc() {
#    cd ~/Projects/$@
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Projects/$@
}

alias serve="ionic serve -bcls"

# Im really lazy
alias vihost='sudo vi /etc/hosts'

# And have a bad memory 
alias highlight=highlightfunc
highlightfunc() {
 less -p '$@' -i
}

# New homestead based project
# Just type name of function in shell to execute it.
func newhomestead()
{
    # where are we?
    PWD=`pwd`
    # Grep last part of dir for projectname
    PROJNAME=`basename $PWD`
    # Projname.dev is a swifty hostname
    # Google apperantly bought the rights to dot-app >.> grrr
    PROJHOST=$PROJNAME.dev
    # just for consistency
    PROJHOST=`echo "$PROJHOST" | awk '{print tolower($0)}'`
    echo Downloading homestead base package
    # Grep homestead
    composer require laravel/homestead --dev > /dev/null
    # Gen base files
    php vendor/bin/homestead make > /dev/null
    echo Setting hostname to $PROJHOST
    sed -i '' "s/homestead.app/$PROJHOST/g" homestead.yaml
    # Mod path a bit so we can stick everything into one folder
    sed -i '' "s/public/$PROJNAME\/public/g" homestead.yaml
    # Collect IP data 
    HOMESIP=`cat Homestead.yaml | grep ip | cut -d\" -f2`
    echo Done.
    echo 
    echo Add the following line to hostfile:
    echo $HOMESIP $PROJHOST
    echo
    echo Or setup DNSMasq 
    echo https://passingcuriosity.com/2013/dnsmasq-dev-osx/
    echo
    echo Now run vagrant up
    echo 
    echo Install laravel? run newlara command
}

# Same story as above
func newlara()
{
    # Where are we?
    PWD=`pwd`
    # Grep last part for project name
    PROJNAME=`basename $PWD`
    # To lowercase please
    PROJNAME=`echo $PROJNAME | awk '{print tolower($0)}'`
    ssh vagrant@localhost -p 2222 composer create-project --prefer-dist laravel/laravel $PROJNAME/$PROJNAME
}

# Instant running services for OS X
#alias rabbit="/usr/local/opt/rabbitmq/sbin/rabbitmq-server"
#alias mongol="mongod --config /usr/local/etc/mongod.conf"

# Just a quick and dirty overview of running virtualmachines 
func vblist()
{
    VBoxManage list vms | cut -d{ -f1 | tr -d '"' > /tmp/vbox_list
    VBoxManage list runningvms | cut -d{ -f1 | tr -d '"' > /tmp/vbox_runlist
    TOTAL=`cat /tmp/vbox_list | wc -l | tr -d "[:space:]" | tr -d "\n"`
    RUN=`cat /tmp/vbox_runlist | wc -l | tr -d "[:space:]" | tr -d "\n"`

    echo --- Registered VMs \(${TOTAL}\)
    echo ---------------------------------
    echo
    grep -Fxv -f /tmp/vbox_runlist /tmp/vbox_list
    echo
    echo --- Running VMs \($RUN\)
    echo ---------------------------------
    echo
    cat /tmp/vbox_runlist
    echo
}

# DNSMasq
func masq()
{
    # Chicken out if there is a existing config
    if [ -e /usr/local/opt/dnsmasq/dnsmasq.conf ];
    then
        echo Found existing config, running DNSMasq
        sudo /usr/local/opt/dnsmasq/sbin/dnsmasq -d -q -C /usr/local/opt/dnsmasq/dnsmasq.conf
        exit # To prevent script from running allong and ruining your config 
    fi
    
    # Write dev resolver to DNSMasq config
    sudo echo "address=/dev/192.168.10.10" > /usr/local/opt/dnsmasq/dnsmasq.conf
    
    # place to store resolvers
    sudo mkdir -p /etc/resolver 

    # dot dev registration please bob :-)
#sudo tee /etc/resolver/dev > /dev/null <<EOF
    #    nameserver 127.0.0.1
    #EOF
    echo "nameserver 127.0.0.1" > /dev/resolver/dev

    # Run DNSMasq
    # -d for no-daemon
    # -q for log querys
    # -C for config file 
    sudo /usr/local/opt/dnsmasq/sbin/dnsmasq -d -q -C /usr/local/opt/dnsmasq/dnsmasq.conf

}

# Hidden files?
func showhidden()
{
    defaults write com.apple.finder AppleShowAllFiles TRUE
    echo killall Finder     to kill finder
}

func hidehidden()
{
    defaults write com.apple.finder AppleShowAllFiles FALSE
    echo killall Finder    to kill finder
    
}

func pass() {
    openssl rand -base64 24 | cut -d= -f1
}

# Load iTerm2 hooks for integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
