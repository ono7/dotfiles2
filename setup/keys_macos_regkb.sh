#!/bin/bash

# refs
  # Apple TN2450
  # https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# set to execute on start up
# sudo defaults write com.apple.loginwindow LoginHook /Users/jlima/bin/keybindings.sh

# normal is 2
# normal minimum is 15 (225 ms)

KRATE=1
INITKRATE=14

# normal is 2, lower is faster
defaults write -g KeyRepeat -int $KRATE
echo "set keyrate to: " $KRATE

# normal minimum is 15 (225 ms) , higher is faster
defaults write -g InitialKeyRepeat -int $INITKRATE
echo "set init-keyrate to: " $INITKRATE

# macbook keyboard

# {"HIDKeyboardModifierMappingSrc":0x70000002a, "HIDKeyboardModifierMappingDst":0x700000031}, backspace -> \
# {"HIDKeyboardModifierMappingSrc":0x700000031, "HIDKeyboardModifierMappingDst":0x70000002a}, \ -> backspace

# maps caps lock to esc, and leftgui to ctr
hidutil property --set '{
        "UserKeyMapping":
            [
                {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x700000029},
                {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e0},
            ]
        }'

	# 0x70000002a -> backspace
	# 0x700000031 --> \, |
	# 0x7000000e7 -> Right GUI/command
	# 0x700000039 -> caps lock
	# 0x70000002a -> backspace/delete
	# 0x700000029 -> Esc

# reset keymaps to defaults, useful when switching keyboards

# hidutil property --set '{ "UserKeyMapping": [ ] }'

