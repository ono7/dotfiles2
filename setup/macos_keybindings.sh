#!/bin/bash

# refs
  # Apple TN2450
  # https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# remaps backspace -> \| , and \| --> backspace

# set to execute on start up
# sudo defaults write com.apple.loginwindow LoginHook /Users/jlima/bin/keybindings.sh


# tenkeyless
# hidutil property --set '{
#         "UserKeyMapping":
#             [
#                 {"HIDKeyboardModifierMappingSrc":0x70000002a, "HIDKeyboardModifierMappingDst":0x700000031},
#                 {"HIDKeyboardModifierMappingSrc":0x700000031, "HIDKeyboardModifierMappingDst":0x70000002a},
#                 {"HIDKeyboardModifierMappingSrc":0x700000029, "HIDKeyboardModifierMappingDst":0x700000035},
#                 {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x700000029},
#             ]
#         }'

        # del -> \|           {"HIDKeyboardModifierMappingSrc":0x70000002a, "HIDKeyboardModifierMappingDst":0x700000031},
        # \| -> del           {"HIDKeyboardModifierMappingSrc":0x700000031, "HIDKeyboardModifierMappingDst":0x70000002a},
        # esc -> ~`           {"HIDKeyboardModifierMappingSrc":0x700000029, "HIDKeyboardModifierMappingDst":0x700000035},
        # left mac key -> esc {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x700000029},

# hhbk
hidutil property --set '{
        "UserKeyMapping":
            [
                {"HIDKeyboardModifierMappingSrc":0x700000029, "HIDKeyboardModifierMappingDst":0x700000035},
                {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x700000029},
                {"HIDKeyboardModifierMappingSrc":0x700000035, "HIDKeyboardModifierMappingDst":0x700000031},
            ]
        }'

        # esc -> ~`           {"HIDKeyboardModifierMappingSrc":0x700000029, "HIDKeyboardModifierMappingDst":0x700000035},
        # left mac key -> esc {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x700000029},
        # ~` -> \|            {"HIDKeyboardModifierMappingSrc":0x700000035, "HIDKeyboardModifierMappingDst":0x700000031},


# reset keymaps to defaults, useful when switching keyboards

# hidutil property --set '{ "UserKeyMapping": [ ] }'
