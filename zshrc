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

# git prompt support
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

# use gnu coreutils
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"

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

    local printf_format="${1:-(%s)}"

    printf -- "$printf_format" "%F{red}$(jobs -p | wc -l | tr -d ' ')%f"
}

# display python virtualenv in the prompt
__venv_ps1()
{
    if ! [ "$VIRTUAL_ENV" ]; then
        return 0
    fi

    local printf_format="${1:-(%s)}"

    printf -- "$printf_format" "%F{cyan}$(basename $VIRTUAL_ENV)%f"
}

# the prompt
precmd () { __git_ps1 "$(__jobs_ps1 '%s | ')$(__venv_ps1 '%s | ')" "%~/ > " "%s | " }



# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
