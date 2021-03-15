# show selection count

useful when showcmd is disabled
g^G

# get release binaries one liner

curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz | tar xzv -

# build release apple m1

## https://github.com/mikelxc/Workarounds-for-ARM-mac

- must build with release flag

git clone git@github.com:neovim/neovim
cd neovim
git remote add qvacua git@github.com:qvacua/neovim.git
git fetch qvacua
git checkout build-arm64-mac
rm -r build/
echo "DEPS_CMAKE_FLAGS += -DCMAKE_OSX_DEPLOYMENT_TARGET=11.00" > local.mk
make CMAKE_BUILD_TYPE=Release SDKROOT=`xcrun --show-sdk-path` CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/nvim"

# homebrew - installs nightly

brew install --HEAD tree-sitter
brew install --HEAD luajit
brew install --HEAD neovim
