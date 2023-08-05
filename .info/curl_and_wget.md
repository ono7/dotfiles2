# download files

-o outputfile
-L follow links

curl -L -o Alacritty.dmg https://github.com/alacritty/alacritty/releases/download/v0.4.3/Alacritty-v0.4.3.dmg

# download files from a list of sources

`wget --no-check-cerficiate -q -i list.txt`

# grep to multiple filters to find more specific functions

`grep -r "toJson" ./ --exclude="compressed*" | grep -v ".send"`
