# remap keys in Linux

ref: `https://unix.stackexchange.com/questions/332457/how-to-send-the-esc-signal-to-vim-when-my-esc-key-doesnt-work`

- if you want to be able to use a single key, as a pure *nix solution (without Vim
  mappings) you could define another key as Esc. Just like Emacs users remap
  CapsLock to Ctrl some Vim users (me included) remap CapsLock to Esc. This works
  for any *nix using X11.

Use xev -event keyboard (and then press CapsLock) to get the keycode for the CapsLock key (for me it is keycode 66). Then you can use xmodmap to remap the key:

`xmodmap -e 'remove Lock = Caps_Lock' -e 'keycode 66 = Escape'`

To get this at login you can add the xmodmap expressions to ~/.Xmodmap as follows:

```sh
remove Lock = Caps_Lock
keycode 66 = Escape
```

Although for the second part YMMV, since not all display managers run
~/.Xmodmap. You may need to add xmodmap .Xmodmap to .xinitrc on some of them.
