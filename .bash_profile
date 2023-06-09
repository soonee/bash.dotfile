#!/bin/bash

##
## BASIC CONFIGURATION
#   ------------------------------------------------------------
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export LC_CTYPE="ko_KR.UTF-8"
export LC_ALL="ko_KR.UTF-8"

# Enable Auto completion
#npm completion >> ~/.bashrc

# npm global configs
npm config set save-exact true
npm config set engine-strict true
npm config set ignore-scripts

# spotlight re-index
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# Color prompt for git
reset=$(tput sgr0)
colorbrown=$(tput setaf 143)
colorgray=$(tput setaf 90)
boldred=$(tput setaf 1)$(tput bold)
boldgreen=$(tput setaf 2)$(tput bold)
boldyellow=$(tput setaf 3)$(tput bold)
boldwhite=$(tput setaf 7)$(tput bold)
lightred=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
red=$(tput setaf 9)

PARENCLR=$'\001\e[0;36m\002'
BRANCHCLR=$(tput setaf 1)

##
##  Change Prompt
#   ------------------------------------------------------------
echo -n -e "\033]0;LeoLaneseltd\007"
echo -e "Kernel Information: $(uname -smr)"
echo -e "${colorbrown}$(bash --version)"
echo -ne "${colorgray}Uptime: "; uptime
#echo -ne "${colorgray}Server time is: "; date


# Git branch in prompt.
#   ------------------------------------------------------------
parse_git_branch() {
 while read -r branch; do
     [[ $branch = \** ]] && current_branch=${branch#* }
 done < <(git branch 2>/dev/null)

 [[ $current_branch ]] && printf ' [%s]' "$current_branch"
}


## Modify Bash Prompt, Enable colors, improve ls
#   ------------------------------------------------------------
user_color='\[\e[32m\]' # 초록색
at_color='\[\e[1;36m\]' # 청록색
host_color='\[\e[91m\]' # 옅은 빨간색
reset_color='\[\e[0m\]' # 색상 리셋
## PS1 option 1
## export PS1="-->\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)\$ "

## PS1 option 2
alias branchname="git branch 2>/dev/null | sed -ne 's/^* \(.*\)/ ${PARENCLR}(${BRANCHCLR}\1${PARENCLR}\)/p'"

GIT_STATUS='$(branchname)'

PROMPT_CHAR="\$"
PS1="\[$boldgreen\]\u\[$cyan\]@\[$boldred\]\h \[$cyan\]\[$reset\]\w\[$cyan\]\[$reset\]$GIT_STATUS\[$reset\]$PROMPT_CHAR "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#   extract:  Extract most know archives with one command
#   -----------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


