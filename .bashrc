# -------------------------------
# paths
# -------------------------------

# add ~/bin to path
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

export PATH


# -------------------------------
# aliases
# -------------------------------
alias mysql=/usr/local/mysql/bin/mysql
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

# bash colors
RED="\[\033[0;31m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
LIGHT_GRAY="\[\033[0;37m\]"

PS_CLEAR="\[\033[0m\]"

if [ "$USER" = "root" ]; then
    PS_S="${RED}#"
else
    PS_S="${YELLOW}\$"
fi

PS1="${GREEN}(${LIGHT_GRAY}\w${GREEN}) ${PS_S}${PS_CLEAR} "

unset PROMPT_COMMAND

if [ $TERM = "dumb" ]; then
    PS1="\$ "
fi

export PS1
