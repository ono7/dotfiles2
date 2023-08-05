### find command information

prod3 ❯ type -a grep
grep is a function with definition

# Defined in /usr/share/fish/functions/grep.fish @ line 6

function grep
command grep --color=auto \$argv
end
grep is /usr/bin/grep
grep is /bin/grep

# read and do something with contents of a file

while read l; do
echo "===\$l==="
done < contact.py
