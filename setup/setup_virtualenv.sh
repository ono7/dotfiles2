#/bin/bash

echo "$0"

echo ################################################################################
echo #                           setup python virtualenv                            #
echo ################################################################################

pip3_file="$HOME/.dotfiles/setup/pip3_freeze.txt"

echo "echo setting up virtualevn prod3.."
if [ -d ~/.virtualenvs/prod3/bin ]; then
  echo 'found virtual env in ~/.virtualenvs/prod3/bin'
  echo 'setting up virtual env'
  echo ''
  source ~/.virtualenvs/prod3/bin/activate
  if [ $? -eq 0 ]; then
    easy_install pip
    pip3 install wheel pytest black pylint neovim pynvim jedi
    pip3 install -r $pip3_file
    # initial pip upgrade must run last
    pip3 install --upgrade pip
    deactivate
  else
    echo "$0"
    echo 'problem activating virtualenv'
  fi
else
  echo 'trying to create virtualenv with python module'
  python3 -m venv ~/.virtualenvs/prod3
  source ~/.virtualenvs/prod3/bin/activate
  if [ $? -eq 0 ]; then
    easy_install pip
    pip3 install wheel pytest black pylint neovim pynvim jedi
    pip3 install -r $pip3_file
    # initial pip upgrade must run last
    pip3 install --upgrade pip
    deactivate
  else
    echo "$0"
    echo 'problem setting up virtualenv'
  fi
fi

echo 'virtualenv setup done!'

