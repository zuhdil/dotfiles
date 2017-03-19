
source ~/.config/xsh/config.sh

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
