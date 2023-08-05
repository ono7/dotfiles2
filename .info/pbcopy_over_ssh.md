
* execute in terminal

  launchctl load ~/Library/LaunchAgents/pbcopy.plist

* pbcopy.plist in .dotfiles

  needs reverse ssh mapping to work and local ~/bin/pbcopy on remote machine

  ~/.ssh/config:

  Host *
  ServerAliveInterval 120
  ServerAliveCountMax 2
  RemoteForward 2224 127.0.0.1:2224


* remote machine:

  needs to have a bash file executable in our path

    prod3 ❯ cat ~/bin/pbcopy

    #!/usr/bin/bash
    cat | nc -q1 localhost 2224

* this only works with neovim, neovim uses g:clipboard and will copy contents
  to * and + registers using set clipboard+=unnamed,unnamedplus (copy to both)
  * = tmux
  + = pbcopy (bash script)

#########################################################################
###                           pbcopy.plist                            ###
#########################################################################

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>localhost.pbcopy</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/bin/pbcopy</string>
    </array>
    <key>inetdCompatibility</key>
    <dict>
      <key>Wait</key>
      <false/>
    </dict>
    <key>Sockets</key>
    <dict>
      <key>Listeners</key>
      <dict>
        <key>SockServiceName</key>
        <string>2224</string>
        <key>SockNodeName</key>
        <string>127.0.0.1</string>
      </dict>
    </dict>
  </dict>
</plist>
