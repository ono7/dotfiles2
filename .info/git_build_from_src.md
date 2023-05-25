# clone specific tag 2023-05-25 v2.40.1


```sh
git clone -b v2.40.1 --depth 1 https://github.com/git/git.git
cd git
make configure
./configure prefix=/usr/local
make prefix=/usr/local all
sudo make prefix=/usr/local install
```
