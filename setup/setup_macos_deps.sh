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
# tmux copy and paste reattach-to-user-namespace
brew install ansifilter wget tree reattach-to-user-namespace reattach-to-user-namespace neovim
brew install fd cmake ack rg coreutils ssh-copy-id jq p7zip kitty curl tmux universal-ctags

# setup omzsh
. ./setup_chsh_zsh.sh

# fonts smoothing disabled..
defaults -currentHost write -g AppleFontSmoothing -int 0
defaults write com.googlecode.iterm2 AppleFontSmoothing -integer 1
