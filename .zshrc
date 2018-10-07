# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd nomatch
unsetopt beep extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jm/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
#
source <(antibody init)

antibody bundle < ~/.zsh_plugins.txt