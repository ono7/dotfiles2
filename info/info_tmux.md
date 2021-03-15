# linux

tmux 2.x install
sudo apt install libevent-dev
sudo apt install libncurses5-dev

# reference

https://gist.github.com/ryin/3106801

# local macos, no sudo tmux

https://github.com/tmux/tmux/wiki/Installing

```bash
tar -zxf libevent-*.tar.gz
cd libevent-*/
./configure --prefix=$HOME/local --enable-shared
make && make install

# $ DIR="/usr/local/"
# $ ./configure CFLAGS="-I$DIR/include" LDFLAGS="-L$DIR/lib"

# configure and make with static librarires, makes it bigger but no dependencies to worry about
PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig ./configure --prefix=$HOME/local --enable-static
make && make install
```

# rename session

(0 is current name)
tmux rename-session -t 0 main
