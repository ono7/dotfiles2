#!/bin/bash

echo "$0"

# define iTerm2 preference directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"

# load iterm2 from preference directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

cp ~/.dotfiles/iterm2/profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/profile.json

################################################################################
#                     font smoothing macos/mojave garbage                      #
################################################################################

if [ `uname` != 'Darwin' ]; then
  echo 'running:' `uname` '--> this script is for macos'
  exit 1
fi

tic -x ~/.dotfiles/xterm-256color-italic.terminfo

echo '========== macos font settings =========='

# Light font smoothing | best so far, iterm2 no lightstrokes on antialiased font!

# defaults -currentHost write -globalDomain AppleFontSmoothing -int 1

# Medium font smoothing

# defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# Strong font smoothing

# defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# Remove custom font smoothing settings

# defaults -currentHost delete -globalDomain AppleFontSmoothing

# enable better font smoothing for mojave
# defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

################################################################################
#                              keyboard settings                               #
################################################################################

echo '========== macos keyboard repeat settings =========='

# set keyrate for faster keyboard repeat

# normal minimum is 15 (225 ms)
# defaults write -g InitialKeyRepeat -int 10
defaults write -g InitialKeyRepeat -int 10

# normal is 2
defaults write -g KeyRepeat -int 1

echo 'macos userland settings set!'

echo 'dont for get to set keybindings '

echo 'command+j -> move focus to menu bar'

echo 'commad+k -> move focus to dock'

echo 'full keyboard access keyboard/shortcuts/all controls'
