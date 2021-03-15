# download all packages using curl -L -o to avoid macos signature/notarization detection

- curl and untar at the same line

  `curl -L http://ftp.gnu.org/gnu/sed/sed-4.8.tar.gz | tar xzvf -`

need to download the following with curl -L -o to work around notarization issues in
catalina

mkdir ~/temp
cd ~/temp

- neovim
  https://neovim.io/

- nodejs
  http://nodejs.org

- yarn
  https://classic.yarnpkg.com

- ripgrep
  https://github.com/BurntSushi/ripgrep/releases

- build libevent
  https://github.com/tmux/tmux/wiki/Installing

- tmux
  https://github.com/tmux/tmux/wiki

`all this should go into ~/local where they become part of $PATH`

- gnu sed (need this on macos)

  http://ftp.gnu.org/gnu/sed/

- terraform
  download from hashicorp.io , place binary in ~/loca/bin

- terraform language server (vim completion)

  - preffered
    https://github.com/juliosueiras/terraform-lsp

  https://github.com/hashicorp/terraform-ls

# install nodejs binaries

wget https://nodejs.org/dist/v12.18.2/node-v12.18.2-darwin-x64.tar.gz
mv node-v12.18.2-darwin-x64 ~/local/node

- working packages using this, alacritty, neovim (nvim-osx64), tmux dependencies

curl -L -o libevent.tar.gz http://libeventwsite/libevent.tar.gz

# use ~/local to compile and install tmux and libevent with out needing to run sudo

https://github.com/tmux/tmux/wiki/Installing

- no need to install ncurses when compiling locally on macos, ncurses is already
  installed

- need to install macos developer tools!

```bash
* Libevent
tar zvxf libevent-*.tar.gz
cd libevent-*/
./configure --prefix=$HOME/local --enable-shared
make && make install

* TMUX

# this works, but not sure how to do pass, --enable-static
PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig ./configure --prefix=$HOME/local

DIR=$HOME/local
./configure CFLAGS="-I$DIR/include" LDFLAGS="-L$DIR/lib"

# configure and make with static librarires, makes it bigger but no dependencies to worry about

make && make install # or copy tmux to ~/local/bin/tmux
```

# store kerberos creds in key chain

kinit --keychain
