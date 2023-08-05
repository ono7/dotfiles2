## INSTALLING EMACS

$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus [options]

`brew install emacs-plus -with-24bit-color`


## colors

green status bar color and high lights #B1D631

black status bar clor preffered $444444

## kill current buffer

`C-x k`

## help

search for function help

`C-h w`

get current keybindings for current window

`C-h b`

## file formatting shortcuts

`helm`  delete-trainling-white-stapaces
    - removes whites spaces from file

## troubleshoot startup issues

`emacs --debug-ijkjjnit`

## when things slow down, remove all packages and reinstall them

`cd ~/.emacs.d/elpa`
`rm -rf *`

this also helps is emacs gets hung up due to a bad or incompatible package
also good to remove all these from time to time as things slow down

## help

`C-h i`

## show bindings

`C-x b`

## upgrade packages in packages buffer (package-list-packages)

    `update all installed packages with U x in the *Packages* buffer`

