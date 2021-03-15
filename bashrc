# NOA bashrc / git support

# term type
# export TERM=xterm-256color
export TREM=xterm-256color-italic

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# fix fugly ls colors...
export LS_COLORS=':ow=01;33'


COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "[$branch]"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "[$commit]"
  fi
}

PS1="\[$COLOR_WHITE\]\w "      # pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_BLUE\]\n\$\[$COLOR_RESET\] "   # '#' for root, else '$'


# aliases and path

alias tree="tree -C -I '*.pyc|__pycache__'"
# alias ls="ls --color=auto"
alias cls='clear'
alias v="vim"
alias vi="vim"
alias vm="nvim"

[[ ! -d ~/.tmp ]] || mkdir -p ~/.tmp

if [ -d "$HOME/local/bin" ] ; then
  PATH="$PATH:$HOME/local/bin"
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

# functions

function cdr {
  # cd to git root
  cd `git rev-parse --show-toplevel`
}

function pyd {
  # create python pakage dictory
  mkdir -p  $1
  touch $1/__init__.py
}

function ginit {
  git init
  cp ~/.dotfiles/gitignore .gitignore
  git add .
  git commit -am 'initial commit'
}

function gitp {
    git pull
}

function gitl {
    # allows git add ., git commit to be executed inline
    my_dir=$PWD
    cdr
    git add .
    git commit -am $1
    git push
    cd $my_dir
}

function gd {
  git diff
}

function gs {
  git status
}

function va {
  if [ -d `git rev-parse --show-toplevel`/venv ]; then
      source `git rev-parse --show-toplevel`/venv/bin/activate
  else
      source $1/bin/activate
  fi
}


# run bash unconditionally

if [[ $EUID -eq 0 ]]; then
  PS1="\[$COLOR_WHITE\]\u:\w "
  PS1+="\[\$(git_color)\]"
  PS1+="\$(git_branch)"           # prints current branch
  PS1+="\[$COLOR_BLUE\]\n\$\[$COLOR_RESET\] "

  export PS1

else
  # settings for all regular users
  case $- in
    *i*)
      # Interactive session. Try switching to bash.
      if [ -z "$BASH" ]; then # do nothing if running under bash already
        bash=$(command -v bash)
        if [ -x "$bash" ]; then
          export SHELL="$bash"
          exec "$bash" -l
        fi
      fi
  esac

fi

if [ -d "/opt/venvs/ansible_prod" ]; then
  # default virtual env if exists
  source /opt/venvs/ansible_prod/bin/activate
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
