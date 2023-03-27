# vim emulation?

https://github.com/NeoVintageous/NeoVintageous

# enable vintage mode

```preferences -> settings
{
  "ignored_packages": [], # remove the vintage package to enable it
  "vintage_start_in_command_mode": true,
  "vintage_ctrl_keys" : true
}
```

# set keybinding for navigation

```preferences -> keybindings
[
  {
    "keys": ["j", "k"],
    "command": "exit_insert_mode",
    "context":
    [
        { "key": "setting.command_mode", "operand": false },
        { "key": "setting.is_widget", "operand": false }
    ]
  },
  {
    "keys": ["ctrl+\\"],
    "command": "toggle_side_bar"
  }
]
```

# other keys

```
/*

sublime key bindings

*/

[
    { "keys": ["ctrl+\\"], "command": "toggle_side_bar" },
]

/*

sublime ignore PEP long line errors

*/

{
  "pep8_ignore":
    [
      "E501"
    ]
}
```
