# copies terminfo to remote server

open up a kitty term and type this command:

kitty +kitten ssh kali@lan160

## build for macos (apple silicon)

https://sw.kovidgoyal.net/kitty/build.html

git clone https://github.com/kovidgoyal/kitty && cd kitty

brew install lcms2

make

make app

sudo mv kitty.app ~/Applications/
