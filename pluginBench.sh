#!/bin/zsh

# $plugins is stated in .zshrc
. ./.zshrc

# loop over it and source the files, time the output

for plugin ($plugins); do
  timer=$(($(gdate +%s%N)/1000000))
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
  now=$(($(gdate +%s%N)/1000000))
  elapsed=$(($now-$timer))
  echo $elapsed":" $plugin
done
