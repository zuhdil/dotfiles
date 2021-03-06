#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/xsh/config.sh

__prompt_command()
{
    __git_ps1 "$(__jobs_ps1 '%s | ')$(__venv_ps1 '%s | ')" "\w/ > " "%s | "
}

PROMPT_COMMAND="__prompt_command"
