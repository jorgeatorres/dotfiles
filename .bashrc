# -------------------------------
# paths
# -------------------------------

# add ~/bin to path
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

export PATH


# -------------------------------
# aliases
# -------------------------------
#alias mysql=/usr/local/mysql/bin/mysql
alias v="vim"
alias n="nano"
alias dir=ls
alias gits="git status"
alias gita="git add"
alias gitc="git commit"
alias gitp="git push"
alias gitd="git diff"
alias django="python manage.py"
alias latex="texdist pdflatex"

# -------------------------------
# prompt
# -------------------------------

# i haz colors
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LSCOLORS=Exfxcxdxbxegedabagacad

# bash colors
RED="\[\033[0;31m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[0;94m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[0;92m\]"
YELLOW="\[\033[0;33m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"

PS_CLEAR="\[\033[0m\]"

if [ "$USER" = "root" ]; then
    PS_S="${RED}#"
else
    PS_S="${RED}\$"
fi

PS1="${CYAN}\w ${PS_S}${PS_CLEAR} "
export PS1

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
