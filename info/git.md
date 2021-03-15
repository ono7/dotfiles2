# highlight code for sharing

* add #L(start num)-L(end num) to the end of URL, see below

  https://github.com/ono7/security_and_bug_hunting/blob/main/hex.lua#L19-L20

# proxy

- fix issues with things using the git protocol instead http://github.com...

git config --global url.https://github.com/.insteadOf git://github.com/

this changes goes into the ~/.dotfiles/gitconfig settings

# change remote to from http to ssh (priv key)

git remote set-url origin git@github.com:ono7/oswe.git

# find current origin url

git remote show origin

or

git config --get remote.origin.url

# alacritty / terminal settings

requires full disk access in security settings for key chain passwords to work

# tags

- add new tag
  git tag -a v1.0 -am "init working vim config with minor plugins"

- push tag to add
  git push origin v1.0

- delete remote tag
  git push --delete origin v1.0

- delete local tag
  git tag -d v1.0

# restore to previous commit by checking out new branch

git checkout -b old-project-state 0ad5a7a6

# delete old branch

git push origin --delete lima

# create new repo and push to remote/origin

login to github or bitbucket
create new repo, git repo url

ginit new project

cd ~/proj
cp ~/.dotfiles/gitignore .
git init
git add .
git commit -am 'init'

git remote add origin git@github.com:ono7/docker_test.git
git push -u origin master

# global ~/.gitignore, also used by ripgrip

- restore deleted files

```
git rev-list -n 1 HEAD -- <file_path>

Then checkout the version at the commit before, using the caret (^) symbol:

git checkout <deleting_commit>^ -- <file_path>
```

# searching

git grep -n "stuff"

# remove commits

bfg --replace-text ~/replace_this.txt repo_name

~/replace_this.txt entries:

blob ->

replaceme
replaceme2

regex ->

regex:(replaceme|replaceme2)

BFG run is complete! When ready, run:

git reflog expire --expire=now --all && git gc --prune=now --aggressi

# remove files already in repo

find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
echo .DS_Store >> .gitignore
git commit -m 'removing DS_Store'

# set editor

git config --global core.editor "vim"
git config --global push.default simple

# force local override

git fetch --all
git reset --hard origin/master

# change repo to ssh

git remote set-url origin git@github.com:username/repo-name-here.git

# add username

https://username@x.x.x.x.x.x/repo/git.git

# enable cached credentials

git config credential.helper store
git config --global credential.helper 'cache --timeout 7200'

# clone specific branch, e.g mac, requires git verxion 1.8+

git clone -b branch --single-branch git://github/repository.git

# git diff, HEAD vs previous commits

If you have just made a commit, or want to see what has changed in the last
commit compared to the current state (assuming you have a clean working tree)
you can use:

`git diff HEAD^`

This will compare the HEAD with the commit immediately prior. One could also do

`git diff HEAD^^`

to compare to the state of play 2 commits ago. To see the diff between the
current state and a certain commit, just simply do:

`git diff b6af6qc`

Where b6af6qc is an example of a commit hash.
