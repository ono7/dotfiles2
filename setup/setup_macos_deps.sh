#/bin/bash

echo "$0"

# macos userland settings
. ./setup_macos_user_settings.sh

echo '========== install homebrew =========='

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if [ $? -ne 0 ]; then
  echo "$0"
  echo 'homebrew install failed'
  exit 1
fi

echo '========== install brew packages =========='

# ansifilter needed to filter out ansi junk on tmux-logging plugin
brew install ansifilter
brew install wget
brew install tree

# tmux copy and paste reattach-to-user-namespace
# brew install reattach-to-user-namespace

# fzf / fd
brew install fd
brew install cmake
brew install ack
brew install ag
brew instal coreutils
brew install ssh-copy-id
brew install jq
brew install p7zip

# setup omzsh
. ./setup_chsh_zsh.sh

# setup fish shell as default
# . ./setup_chsh_fish.sh

# if [ $? -eq 0 ]; then
#   echo 'fish shell is good to go..'
# fi

# fonts smoothing disabled..
defaults -currentHost write -g AppleFontSmoothing -int 0
