#

- configure all options and reboot
  - for extra packages choose add: git neovim
    `pacman-key --init`
    `pacman-key --populate`
    `archinstall`
    `cd /opt, git clone https://aur.archlinux.org/yay.git.git`
    `chown -R jlima:jlima yay.git`
    `cd yay-git; makepkg -si`

## themes

(darcula)
`xfce4-appearance-settings`
`lxappearance`
