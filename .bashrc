# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

PS1='\[\033[01;35m\][\h \u@\[\033[00m\]\[\033[01;35m\]\W]\[\033[00m\]\$ '                                                                 
export SVN_EDITOR='vim'
#export LANG=C
alias vi='vim'
alias ls='ls  --color -p --ignore=*.pyc -I "*.files" -I "tags" -I "*.taghl" -I "cscope*"'
alias l='ls'
alias ll='ls -l'
alias grep="grep --color "
export LC_ALL="zh_CN.utf8"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib64/mysql/

alias cdserver='cd ~/erver'
#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
export PATH=$PATH:~/bin/:~/pomelo/bin/

source ~/.git-completion.bash

ulimit -c unlimited
export TERM="xterm-256color"
alias tmux="tmux -2"

