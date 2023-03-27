https://superuser.com/questions/399594/color-scheme-not-applied-in-iterm2

fish:

if not -q CLICOLOR
  set -Ux CLICOLOR 1
end

bash:

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# set iterm2 terminal type
iterm2 terminal type = xterm-256color
