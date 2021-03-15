## find only non binary files in linux

`find . -type f -exec grep -Iq . {} \; --print0 | tar -vczf /tmp/1.tgz -T -`

## tar only certain file extensions, keep using -o -name `"*.ext"` to add more

`find . -name "*.php" -o -name "*.html" | tar -vzcf /tmp/1.tgz -T -`

`find . -name "*.php" -o -name "*.html" | tar -vzcf /tmp/1.tgz -T -`

## rip grep results to vim, for easier filtering

rg "tmpFolderBaseName" --trim | vim

## find directory permissions

`find /var/dir -type d -perm -o+w`

## find containing regex and pass to sed

- dry run

  `rg -l '.*test_to_sub.*' | xargx sed 's/test_to_sub/sub_with_this/g'`

- inplace

  `rg -l '.*test_to_sub.*' | xargx sed -i 's/test_to_sub/sub_with_this/g'`

## find with case insensitivity (-iname)

`find ./ -iname "*.html"`

## grep include only certain files

`grep -r "document.write" ./ --include *.html`
