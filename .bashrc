# ~/.bashrc: executed by bash(1) for non-login shells.  see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

template(){
cat<<EOF
/**
 *   author: Vinzz34
EOF
echo " *   Created: $(date +%d).$(date +%m).$(date +%Y) $(date +%I):$(date +%M):$(date +%S)"
cat<<EOC
**/
#include<bits/stdc++.h>

using namespace std;

#define ll long long
#define ar array
#define ld long double
#define vi vector<int>
#define vpii vector<pair<int,int>>
#define PB push_back
#define MP make_pair
#define fi first
#define se second
#define sz(a) int((a).size())
#define FOR(a,b,c) for(int a=b;a<(int)(c);a++)
#define MOD 1000000007
#define EACH(v) for(auto x : v)
#define VINZZ

int main(){
	ios::sync_with_stdio(false);
	cin.tie(0);
	return 0;
}
EOC
}
create(){
	a=($@)
	for i in "${a[@]}"
	do
		template > $i.cpp
		echo creating $i.cpp ...
		subl $i.cpp
	done
}
open(){
	a=($@)
	for i in "${a[@]}"
	do
		echo opening $i.cpp ...
		subl $i.cpp
	done
}
del(){
	a=($@)
	for i in "${a[@]}"
	do
		echo deleting $i.cpp ...
		if test -f "$i.cpp"; then
		  rm $i.cpp
		fi
		if test -f "$i"; then
		  rm $i
		fi
	done
}
run(){
	echo [DEBUG MODE] compiling $1.cpp with c++17.
	g++ -std=c++17 -O2 -Wall -Wno-unused-variable $1.cpp -o $1
	echo Input:
	./$1
}

rng(){
	echo Genarating ...
	echo $1
	for (( i=1; i<=$1; i++ ))
	do
		printf "$((1 + $RANDOM % 10)) "
	done
	printf "\n"
}

mkcdir(){
	echo making directory $1 ....
	mkdir $1
	cd $1
}

cfsamplegen(){
	python3 /home/vinzz/github/CFSampleGenerator/main.py $1
}

runsamples(){
	echo [DEBUG MODE] compiling $1.cpp with c++17.
	echo Output:
	g++ -std=c++17 -O2 -Wall -Wno-unused-variable $1.cpp -o $1
	./$1 < $1.in > $1-1.out
	cat $1-1.out
	echo Expected:
	cat $1.out
	echo ------------
	GREEN='\033[1;32m'
	RED='\033[0;31m'
	if cmp -s "$1-1.out" "$1.out"; then
	    printf "${GREEN}Passed!\n"
	else
	    printf "${RED}Failed!\n"
	fi
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\D{[%I:%M:%S %p]}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
