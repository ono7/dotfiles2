local git_worktree_ok, git_worktree_config = pcall(require, "git-worktree")
if not git_worktree_ok then
  print("Error in pcall git-worktree -> ~/.dotfiles/nvim/lua/plugins/git-worktree.lua")
  return
end

git_worktree_config.setup()
