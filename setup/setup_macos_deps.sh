#/bin/bash

echo "$0"

# macos userland settings
. ./setup_macos_user_settings.sh

echo '========== install homebrew =========='

[ ! -d /opt/homebrew/bin ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# if [ $? -ne 0 ]; then
#   echo "$0"
#   echo 'homebrew install failed'
#   exit 1
# fi

echo '========== install brew packages =========='

# ansifilter needed to filter out ansi junk on tmux-logging plugin
# tmux copy and paste reattach-to-user-namespace
brew install ansifilter wget tree go neovim rar clang-format zoxide wezterm
brew install fd cmake ack rg coreutils ssh-copy-id jq p7zip curl tmux universal-ctags mtr lua ninja rust npm starship
brew install bpytop pinentry-mac
brew install golang delve amethyst
# npm install lua-fmt prettier jsonlint typescript typescript-language-server eslint jsonlint -g
npm install lua-fmt prettier jsonlint typescript eslint jsonlint -g

# setup omzsh
# . ./setup_chsh_zsh.sh

# fonts smoothing disabled..
# defaults -currentHost write -g AppleFontSmoothing -int 0
# defaults write com.googlecode.iterm2 AppleFontSmoothing -integer 1
