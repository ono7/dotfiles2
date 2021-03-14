#/bin/bash

echo "$0"

cd ~

echo 'setting up tmux dependencies..'
mkdir -p ~/.tmux/plugins
git clone https://github.com/soyuka/tmux-current-pane-hostname ~/.tmux/plugins
if [ $? -ne 0 ]; then
  echo "$0"
  echo 'problem setting up tmux plugins..'
  exit 1
fi

echo 'tmux done...'
