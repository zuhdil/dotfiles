#- ALIASES
#------------------------------------

alias ls="ls --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias less="less -R"
alias tmux='tmux -2 -f ~/.config/tmux/init.conf'
alias vim='nvim'



#- ENV
#------------------------------------

if [[ $(uname -s) == "Darwin" ]]; then
    source ~/.config/xsh/macos.sh
else
    source ~/.config/xsh/linux.sh
fi

export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"



#- PROMPT
#------------------------------------

# display git status in prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="brach"
GIT_PS1_SHOWUPSTREAM="auto"

# display background jobs in the prompt
__jobs_ps1 ()
{
    if ! [ "$(jobs -p)" ]; then
        return 0
    fi

    if [ -n ${ZSH_VERSION-} ]; then
        local color='%F{red}'
        local clear='%f'
    else
        local color='\[\e[31m\]'
        local clear='\[\e[0m\]'
    fi

    local printf_format="${1:-(%s)}"

    printf -- "$printf_format" "$color$(jobs -p | wc -l | tr -d ' ')$clear"
}

# display python virtualenv in the prompt
__venv_ps1()
{
    if ! [ "$VIRTUAL_ENV" ]; then
        return 0
    fi

    if [ -n ${ZSH_VERSION-} ]; then
        local color='%F{131}'
        local clear='%f'
    else
        local color='\[\e[33m\]'
        local clear='\[\e[0m\]'
    fi

    local printf_format="${1:-(%s)}"

    printf -- "$printf_format" "$color$(basename $VIRTUAL_ENV)$clear"
}
