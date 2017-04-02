
# git prompt support
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

# use gnu coreutils
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"


# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias showallfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias dontshowallfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias systemupdate='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup;'
