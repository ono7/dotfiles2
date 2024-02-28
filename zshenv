alias f='fd -tf'
alias l='less -R '
alias m='more '
alias cdr='cd "$(git rev-parse --show-toplevel 2>/dev/null)"  &>/dev/null'

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

ga () {
    # Check for untracked files
    mydir=pwd
    untracked_files=$(git status --porcelain | grep '^??' | cut -c4-)
    if [ -z "$untracked_files" ]; then
        echo "No new untracked files."
    else
        echo "Untracked files detected."
        echo " "
        echo "$untracked_files"
        echo " "
        echo "Do you want to add all untracked files? (y/n)"
        read -r user_input
        if [[ $user_input =~ ^[Yy]$ ]]; then
            cdr
            git add -A
            cd $mydir
            echo "Added all untracked files."
        fi
    fi

    # Proceed with the rest of the function
    if [ "$#" -eq 0 ]; then
        git add -p
    else
        git add "$@"
    fi
    git commit
}

gac() {
  if [ "$#" -eq 0 ]; then
    git add -p
  else
    git add "$@"
  fi
  git commit
}

alias gd='git diff '
alias gds='git diff --staged'
alias gc='git commit '
alias gco='git checkout '
alias gf='git fetch --all'

# deletes merged branches
# alias gdm="git branch --merged | grep -Pv '(^\*|master|main)' | xargs git branch -d"
alias gdm="git branch --merged | grep -Pv '(^\*|master|main|production|development)' | xargs echo"
alias gdmr="git branch --merged | grep -Pv '(^\*|master|main|production|development)' | xargs git branch -d"

# git follow a file history gfh nvim/init.lua
alias gfh="git log --follow -p"

# view logs with changes with gl -p
alias gl="git log --graph --abbrev=10 --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:green)(%(committerdate:relative))%(color:reset) %(contents:subject)'"
alias gp='git push '
alias gpu='git pull'
alias gr='git reflog '
alias gs='git status '
alias gwa='git worktree add '
alias gwl='git worktree list'
alias gwr='git worktree remove '

alias p='podman'
