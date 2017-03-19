
# git prompt support
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

# use gnu coreutils
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"
