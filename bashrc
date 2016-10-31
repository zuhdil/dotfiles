#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# ENV VARIABLES =====================================================

export PATH=$HOME/.local/bin:$PATH

export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export VISUAL="nvim"
export EDITOR="nvim"


# Fix unreadable ntfs directory color ===============================

if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.config/dircolors/config && eval "$(/usr/bin/dircolors -b $HOME/.config/dircolors/config)"
fi


# ALIASES ===========================================================

alias ls='ls --color=auto'
alias tmux='tmux -2 -f ~/.config/tmux/config'
alias vim='nvim'


# COMMAND PROMPT ====================================================

# support display repository status in the prompt
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="brach"
GIT_PS1_SHOWUPSTREAM="auto"

# support display background jobs in the prompt
__jobs_ps1 ()
{
    if ! [ "$(jobs -p)" ]; then
        return 0
    fi

    local c_red='\[\e[31m\]'
    local c_clear='\[\e[0m\]'
    local printf_format=' (%s)'

    printf -- "$printf_format" "$c_red$(jobs -p | wc -l)$c_clear"
}

# support display python virtualenv in the prompt
__venv_ps1()
{
    if ! [ "$VIRTUAL_ENV" ]; then
        return 0
    fi

    local c_yellow='\[\e[33m\]'
    local c_clear='\[\e[0m\]'
    local printf_format='(%s) '

    printf -- "$printf_format" "$c_yellow$(basename $VIRTUAL_ENV)$c_clear"
}

# custom command prompt
__prompt_command()
{
    local c_purple='\[\e[35m\]'
    local c_clear='\[\e[0m\]'

    __git_ps1 "$(__venv_ps1)$c_purple\w$c_clear" "$(__jobs_ps1)\n\$ " " [%s]"
}

# support open new terminal in the current directory (on termite)
if [[ $TERM == xterm-termite ]]; then
    source /etc/profile.d/vte.sh
    PROMPT_COMMAND="__prompt_command; __vte_osc7"
else
    PROMPT_COMMAND="__prompt_command"
fi
