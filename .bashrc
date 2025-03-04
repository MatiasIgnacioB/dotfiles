#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


# Adopt color scheme from pywal
(cat ~/.cache/wal/sequences &)

# pokeget drapion --hide-name
neofetchalias dotfiles='git --git-dir=/home/Zenith/.dotfiles --work-tree=/home/Zenith'
