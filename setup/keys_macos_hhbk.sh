#!/bin/bash

# swap left alt for win (command) keys

# refs
  # Apple TN2450
  # https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# set to execute on start up
# sudo defaults write com.apple.loginwindow LoginHook /Users/jlima/bin/keybindings.sh

# normal is 2, lower is faster

# normal minimum is 15 (225 ms) , higher is faster

# Keyboard Left Alt 0xE2
# Keyboard Left GUI 0xE3
# Keyboard Right Alt 0xE6
# Keyboard Right GUI 0xE7

# # macbook keyboard
# hidutil property --set '{
#         "UserKeyMapping":
#             [
#                 {"HIDKeyboardModifierMappingSrc":0x70000002a, "HIDKeyboardModifierMappingDst":0x700000031},
#                 {"HIDKeyboardModifierMappingSrc":0x700000031, "HIDKeyboardModifierMappingDst":0x70000002a},
#                 {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x7000000e4},
#                 {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e6},
#                 {"HIDKeyboardModifierMappingSrc":0x7000000e2, "HIDKeyboardModifierMappingDst":0x7000000e3},
#                 {"HIDKeyboardModifierMappingSrc":0x7000000e3, "HIDKeyboardModifierMappingDst":0x7000000e2},
#             ]
#         }'
#
# macbook keyboard

hidutil property --set '{
        "UserKeyMapping":
            [
                {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e6},
                {"HIDKeyboardModifierMappingSrc":0x7000000e6, "HIDKeyboardModifierMappingDst":0x7000000e7}
            ]
        }'

# reset keymaps to defaults, useful when switching keyboards

# hidutil property --set '{ "UserKeyMapping": [ ] }'
