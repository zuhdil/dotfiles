#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# ENV VARIABLES =====================================================

export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export VISUAL="nvim"
export EDITOR="nvim"


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
    local c_red='\[\e[31m\]'
    local c_clear='\[\e[0m\]'
    local printf_format=' (%s)'

    if ! [ "$(jobs -p)" ]; then
        return 0
    fi

    local jobs_string=$c_red$(jobs -p | wc -l)$c_clear
    printf -- "$printf_format" "$jobs_string"
}

# custom plain command prompt without bells and whistles
__custom_ps1()
{
    local c_color='\[\e[35m\]'
    local c_clear='\[\e[0m\]'

    printf -- "%s" "$c_color\w$c_clear"
}

# support open new terminal in the current directory (on termite)
source /etc/profile.d/vte.sh
__termite_vte_ps1() {

    __git_ps1 "$(__custom_ps1)" "$(__jobs_ps1)\n\$ " " [%s]"
    printf -- "%s" "$(__vte_osc7)"
}

if [[ $TERM == xterm-termite ]]; then
    PROMPT_COMMAND="__termite_vte_ps1"
else
    PROMPT_COMMAND='__git_ps1 "$(__custom_ps1)" "$(__jobs_ps1)\n\$ " " [%s]"'
fi
