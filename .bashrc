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
alias v="vim"
alias n="nano"
alias s="subl"
alias t="tmate"
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

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    # Run colortest.sh for full list of colors.
    local PS_CLEAR="\[\033[0m\]"    
    local COLOR_NICE_BLUE='\e[38;5;111m'
    local COLOR_NICE_GREEN='\e[38;5;148m'
    local COLOR_NICE_YELLOW='\e[38;5;179m'
    local COLOR_NICE_RED='\e[38;5;198m'

    if [ "$USER" = "root" ]; then
        local PS_S="${COLOR_NICE_RED}#"
    else
        local PS_S="${COLOR_NICE_GREEN}\$"
    fi    

    PS1="${COLOR_NICE_BLUE}\${NEW_PWD} ${PS_S}${PS_CLEAR} "
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
