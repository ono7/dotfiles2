# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export TERM=xterm-256color
export CLICOLOR=1
alias tree="tree -C -I '*.pyc|__pycache__'"

[[ -d ~/.tmp ]] || mkdir -p ~/.tmp

if [ -d "$HOME/local/bin" ] ; then
  PATH="$PATH:$HOME/local/bin"
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

if [ -d ~/.virtualenvs/prod3 ]; then
  # default virtual env if exists
  source ~/.virtualenvs/prod3/bin/activate
elif [ -d "/opt/venvs/ansible_prod" ]; then
  # default virtual env if exists
  source /opt/venvs/ansible_prod/bin/activate
fi

alias gd='git diff'
alias gs='git status'

alias cdr='cd "$(git rev-parse --show-toplevel)"  &>/dev/null'
alias c='clear'

function vs () {
  vim $(fzf || '' 2>/dev/null)
}

function ginit () {
  git init
  cp ~/.dotfiles/gitignore .gitignore
  git add .
  git commit -am 'initial commit'
}

function gitl () {
    my_dir=$PWD
    cdr
    git add .
    if test -z "$1"; then
      git commit '-m updates'
    else
      git commit '-m' $1
    fi
    git push
    cd $my_dir
}

function dotp () {
    my_dir=$PWD
    cd ~/.dotfiles
    git pull
    cd ~/.info
    git pull
    cd $my_dir
}

function dotc () {
    my_dir=$PWD
    cd ~/.dotfiles
    git pull
    git add .
    git commit '-m' 'updates'
    git push
    cd ~/.info
    git pull
    git add .
    git commit '-m' 'updates'
    git push
    cd $my_dir
}

function ta () {
  if [ ! -z "$1" ]; then
    tmux new-session -s "$1" || tmux attach -t "$1"
  else
    tmux attach -t main || tmux new-session -s main
  fi
}

# activate virtual environment if there is one in this repo
function va () {
  if [[ -d $(git rev-parse --show-toplevel)/venv ]]; then
    source $(git rev-parse --show-toplevel)/venv/bin/activate
  fi
}

# deactivate virtual environment if there is one in this repo
function vd () {
  deactivate 2> /dev/null
  source $HOME/.virtualenvs/prod3/bin/activate
}

if [[ -d ~/nvim/bin ]]; then
  alias vim='~/nvim/bin/nvim'
  # legacy vim
  alias vi=vim
  alias vil='/usr/bin/vim'
  alias vimdiff='~/nvim/bin/nvim -d'
elif command -v nvim &>/dev/null; then
  alias vim=$(which nvim)
  alias vi=vim
  # legacy vim
  alias vil=vim
  alias vil='/usr/bin/vim'
  alias vimdiff='nvim -d'
  # alias vll="vim  +\"'\"0"
  alias vl="vim -c \"normal '0\" -c \"bn\" -c \"bd\""
fi

export EDITOR=vim
export FZF_DEFAULT_OPTS='--height 40% --no-preview'

if command -v fd &> /dev/null; then
  _fzf_compgen_path() {
    fd -I --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd -I --type d --hidden --follow --exclude ".git" . "$1"
  }
  export FZF_ALT_C_COMMAND='fd -I --type d --exclude .git --follow --hidden'
  export FZF_DEFAULT_COMMAND='fd -I --type f --exclude .git --follow --hidden'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
  echo 'download fd from: https://github.com/sharkdp/fd/releases'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# unset display in wsl or vim will starup slow
[[ $(uname -a) == *"Microsoft"* ]] && unset DISPLAY
