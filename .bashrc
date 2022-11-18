#
# ~/.bashrc
#

source ~/.bash_git

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias bgswap='feh --bg-max --randomize ~/.wallpaper/*'
alias la='ls -lah'
alias grep='grep --color=always'
