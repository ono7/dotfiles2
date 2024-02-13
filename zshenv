alias f='fd -tf'
alias l='less -R '
alias m='more '

ga() {
  if [ "$#" -eq 0 ]; then
    git add -p
  else
    git add "$@"
  fi
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
# view logs with changes with gl -p
alias gl="git log --graph --abbrev=10 --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp='git push '
alias gpu='git pull'
alias gr='git reflog '
alias gs='git status '
alias gwa='git worktree add '
alias gwl='git worktree list'
alias gwr='git worktree remove '
