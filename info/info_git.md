# GIT INIT

* initializes a project in local directory
	- creates .git folder in local folder

# GIT IGNORE

* .gitingore
	- ignore files listed in this file, example:

	'''
	.DS_Store
	*.xcurserstate
	project.xcworkstpace/
	xcursedata

	'''

# GIT COMMANDS

* git remote add origin git@github.com:loopback1/test (ssh)
	- links current local project to remote github project


* git remote add origin git@github.com:loopback1/test (https)
	- same as above but https


* git push -u origin master
	- push code from local repo called master to remote

* git clone git@github.com:loopback1/test.git
	- clone remote to local using ssh

* git pull origin master
	- updates local repo with latest version
	- git

* git add filename.md
	- stages file

* git reset HEAD file name
	- unstage file

* git checkout -b newbrachname (staging)
	- create new branch
	- changes made in new branch can be merged into master
	- work on branch to keep master in working order
* git branch -d newbranchname (delete branch)


# GIT WORKFLOW

- modified files -> staged files (using git add)
	-> staged files -> commited files (git commit -m)
		-> commit -> pushed files (git push)


# BRANCHING

# CHECK OUT NEW BRANCH
git checkout -b branchname

# PUSH ORIGIN (LOCAL) TO BRANCHNAME AND SETUP TRACKING
git push -u origin branchname

# CHANGE TO MASTER BRANCH
git checkout master

# CHANGE TO 'BRANCHNAME' BRANCH
git checkout branchname

# CHECK CURRENT BRANCH
git status

# FETCH FROM REMOTE (FETCH IS SAFE AND DOES NOT OVERWRITE LOCAL)
git fetch

# CHECKOUT A NEW BRANCH UNDER DIFFERNT NAME
git checkout -b devbranch origin/devbranch

# MERGE DEVBRANCH TO MASTER
switch to devbranch 'checkout devbranch'
	git merge master
	git checkout master
	git merge --no-ff devbranch
	# push to github
	git push -u origin master

# DELETE REMOTE AND LOCAL BRANCH
git push origin --delete branch

# UPSTREAM REPOSITORIES
- used when forking a repo but we need to keep our local copy
	in sync with the original master

* after cloning a forked repo, tell the forked version
  that there is an upstream original repo as well

git remote add upstream https://github.com/username/repo.git

* check all remotes
git remote -v

* fetch from upstream to update forked local repo
git fetch upstream

* move to local master branch
git checkout master

* merge changes from upstream original master into local master
git merge upstream/master

# GIT STASH
- temporary storage for changes not ready to commit
- useful when having to switch branches when not ready to commit

git stash

* get changes out of stash
git stash pop --index
