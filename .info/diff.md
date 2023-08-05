# git diff (patching)

`make changes`

1. create patch: `git diff > patch.txt`
2. restore: `git apply patch.txt`

or

3. apply without git installed: `patch -p1 patch.txt`
