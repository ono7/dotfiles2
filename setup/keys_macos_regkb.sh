#!/bin/bash

# refs
  # Apple TN2450
  # https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# set to execute on start up
# sudo defaults write com.apple.loginwindow LoginHook /Users/jlima/bin/keybindings.sh

# normal is 2
defaults write -g KeyRepeat -int 1

# normal minimum is 15 (225 ms)
defaults write -g InitialKeyRepeat -int 10


# macbook keyboard
hidutil property --set '{
        "UserKeyMapping":
            [
                {"HIDKeyboardModifierMappingSrc":0x70000002a, "HIDKeyboardModifierMappingDst":0x700000031},
                {"HIDKeyboardModifierMappingSrc":0x700000031, "HIDKeyboardModifierMappingDst":0x70000002a},
                {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x7000000e4},
                {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e6},
            ]
        }'

# reset keymaps to defaults, useful when switching keyboards

# hidutil property --set '{ "UserKeyMapping": [ ] }'
