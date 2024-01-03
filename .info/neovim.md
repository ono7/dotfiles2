
# change list jump

g; - jump forward in change list
g, - jump back in change list

## key bindings

# https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/

# c-o jump list

--[[

vert sf ex*v - open split file search for ex*v pattern
c-Wx - change vert view (flip verts)
20vs . - open split 20 chars wide from current working directory showing files

diff:
open file
vert sf new\*file
windo difft

]m goto next method
3d]m delete next 3 methods

git pull --merge
gw - format, but maintain cursor position (ref: gq)
<c-h> (delete back) and g; (last edit) or `. (last edit mark) and `` (last jump)
command of the day < c-h delete back in insert mode
c-i/o> gi, zi (fold enable toggle), X delete left

npm install lua-fmt prettier pyright jsonlint -g
yp = json to yaml
pip install black pylint yamllint yp

echo system('base64 -d', @")
:<c-f> (command search)
:browse filter /drone/ oldfiles " filter oldfiles

insert mode, <c-r> = system('date'), or 2+2

    -- Lima

-- useful for debugging lua in vim :lua put({1,2,3,4})

function \_G.put(...)
local objects = {}
for i = 1, select("#", ...) do
local v = select(i, ...)
table.insert(objects, vim.inspect(v))
end
print(table.concat(objects, "\n"))
return ...
end

--- lua pattern magic characters ^$()%.[]\*+-?

--]]

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
