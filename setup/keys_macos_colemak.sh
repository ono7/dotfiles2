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

# maps caps lock to esc, and leftgui to ctr
# COLEMAK LAYOUT	
hidutil property --set '{
        "UserKeyMapping":
            [
                {"HIDKeyboardModifierMappingSrc":0x700000039, "HIDKeyboardModifierMappingDst":0x700000029},
                {"HIDKeyboardModifierMappingSrc":0x7000000e7, "HIDKeyboardModifierMappingDst":0x7000000e0},
                {"HIDKeyboardModifierMappingSrc" : 0x700000011, "HIDKeyboardModifierMappingDst" : 0x70000000e},
                {"HIDKeyboardModifierMappingSrc" : 0x700000016, "HIDKeyboardModifierMappingDst" : 0x700000015},
                {"HIDKeyboardModifierMappingSrc" : 0x700000007, "HIDKeyboardModifierMappingDst" : 0x700000016},
                {"HIDKeyboardModifierMappingSrc" : 0x700000009, "HIDKeyboardModifierMappingDst" : 0x700000017},
                {"HIDKeyboardModifierMappingSrc" : 0x70000000a, "HIDKeyboardModifierMappingDst" : 0x700000007},
                {"HIDKeyboardModifierMappingSrc" : 0x70000000e, "HIDKeyboardModifierMappingDst" : 0x700000008},
                {"HIDKeyboardModifierMappingSrc" : 0x700000008, "HIDKeyboardModifierMappingDst" : 0x700000009},
                {"HIDKeyboardModifierMappingSrc" : 0x70000001c, "HIDKeyboardModifierMappingDst" : 0x70000000d},
                {"HIDKeyboardModifierMappingSrc" : 0x700000012, "HIDKeyboardModifierMappingDst" : 0x70000001c},
                {"HIDKeyboardModifierMappingSrc" : 0x70000000c, "HIDKeyboardModifierMappingDst" : 0x700000018},
                {"HIDKeyboardModifierMappingSrc" : 0x700000018, "HIDKeyboardModifierMappingDst" : 0x70000000F},
                {"HIDKeyboardModifierMappingSrc" : 0x700000013, "HIDKeyboardModifierMappingDst" : 0x700000033},
                {"HIDKeyboardModifierMappingSrc" : 0x700000015, "HIDKeyboardModifierMappingDst" : 0x700000013},
                {"HIDKeyboardModifierMappingSrc" : 0x700000017, "HIDKeyboardModifierMappingDst" : 0x70000000A},
                {"HIDKeyboardModifierMappingSrc" : 0x700000033, "HIDKeyboardModifierMappingDst" : 0x700000012},
                {"HIDKeyboardModifierMappingSrc" : 0x70000000d, "HIDKeyboardModifierMappingDst" : 0x700000011},
                {"HIDKeyboardModifierMappingSrc" : 0x70000000f, "HIDKeyboardModifierMappingDst" : 0x70000000c},
            ]
        }'


# colemak
# n -> k 11 0e
# s -> r 16 15
# d -> s 07 16
# f -> t 09 17
# g -> d 0a 07
# k -> e 0e 08
# e -> f 08 09
# y -> j 1c 0d
# o -> y 12 1c
# i -> u 0c 18
# u -> l 18 0F
# p -> ; 13 33
# r -> p 15 13
# t -> g 17 0A
# : -> o 33 12
# j -> n 0d 11
# l -> i 0f 0c

# Keyboard a and A - 0x04
# Keyboard b and B - 0x05
# Keyboard c and C - 0x06
# Keyboard d and D - 0x07
# Keyboard e and E - 0x08
# Keyboard f and F - 0x09
# Keyboard g and G - 0x0A
# Keyboard h and H - 0x0B
# Keyboard i and I - 0x0C
# Keyboard j and J - 0x0D
# Keyboard k and K - 0x0E
# Keyboard l and L - 0x0F
# Keyboard m and M - 0x10
# Keyboard n and N - 0x11
# Keyboard o and O - 0x12
# Keyboard p and P - 0x13
# Keyboard q and Q - 0x14
# Keyboard r and R - 0x15
# Keyboard s and S - 0x16
# Keyboard t and T - 0x17
# Keyboard u and U - 0x18
# Keyboard v and V - 0x19
# Keyboard w and W - 0x1A
# Keyboard x and X - 0x1B
# Keyboard y and Y - 0x1C
# Keyboard z and Z - 0x1D

# Keyboard Return (Enter) - 0x28
# Keyboard Print Screen - 0x46
# Keyboard Non-US \ and | - 0x64
# Keyboard Escape - 0x29
# Keyboard Scroll Lock - 0x47
# Keyboard Application - 0x65
# Keyboard Delete (Backspace) - 0x2A
# Keyboard Pause - 0x48
# Keyboard Power - 0x66
# Keyboard Tab - 0x2B
# Keyboard Insert - 0x49
# Keyboard Spacebar - 0x2C
# Keyboard Home - 0x4A
# Keyboard - and _ - 0x2D
# Keyboard Page Up - 0x4B
# Keyboard = and + - 0x2E
# Keyboard Delete Forward - 0x4C
# Keyboard [ and { - 0x2F
# Keyboard End - 0x4D
# Keyboard ] and } - 0x30
# Keyboard Page Down - 0x4E
# Keyboard \ and | - 0x31
# Keyboard Right Arrow - 0x4F
# Keyboard Non-US # and ~ - 0x32
# Keyboard Left Arrow - 0x50
# Keyboard ; and : - 0x33
# Keyboard Down Arrow - 0x51
# Keyboard ' and " - 0x34
# Keyboard Up Arrow - 0x52
# Keyboard Grave Accent and Tilde - 0x35
# Keyboard , and "<" - 0x36
# Keyboard . and ">" - 0x37
# Keyboard / and ? - 0x38
# Keyboard Left Control - 0xE0
# Keyboard Caps Lock - 0x39
# Keyboard Left Shift - 0xE1
# Keyboard Left Alt - 0xE2
# Keyboard Left GUI - 0xE3
# Keyboard Right Control - 0xE4
# Keyboard Right Shift - 0xE5
# Keyboard Right Alt - 0xE6
# Keyboard Right GUI - 0xE7

# Keypad 6 and Right Arrow - 0x5E
# Keypad 7 and Home - 0x5F
# Keypad 8 and Up Arrow - 0x60
# Keypad 9 and Page Up - 0x61
# Keypad 0 and Insert - 0x62
# Keypad . and Delete - 0x63
# Keypad = - 0x67
# Keypad Num Lock and Clear - 0x53
# Keypad / - 0x54
# Keypad * - 0x55
# Keypad - - 0x56
# Keypad + - 0x57
# Keypad Enter - 0x58
# Keypad 1 and End - 0x59
# Keypad 2 and Down Arrow - 0x5A
# Keypad 3 and Page Down - 0x5B
# Keypad 4 and Left Arrow - 0x5C
# Keypad 5 - 0x5D

# Keyboard F7 - 0x40
# Keyboard F8 - 0x41
# Keyboard F9 - 0x42
# Keyboard F10 - 0x43
# Keyboard F11 - 0x44
# Keyboard F12 - 0x45
# Keyboard F13 - 0x68
# Keyboard F14 - 0x69
# Keyboard F15 - 0x6A
# Keyboard F16 - 0x6B
# Keyboard F17 - 0x6C
# Keyboard F18 - 0x6D
# Keyboard F19 - 0x6E
# Keyboard F20 - 0x6F
# Keyboard F21 - 0x70
# Keyboard F22 - 0x71
# Keyboard F23 - 0x72
# Keyboard F24 - 0x73
# Keyboard F1 - 0x3A
# Keyboard F2 - 0x3B
# Keyboard F3 - 0x3C
# Keyboard F4 - 0x3D
# Keyboard F5 - 0x3E
# Keyboard F6 - 0x3F

# Keyboard 5 and % - 0x22
# Keyboard 6 and ^ - 0x23
# Keyboard 7 and & - 0x24
# Keyboard 8 and * - 0x25
# Keyboard 9 and ( - 0x26
# Keyboard 0 and ) - 0x27
# Keyboard 1 and ! - 0x1E
# Keyboard 2 and @ - 0x1F
# Keyboard 3 and # - 0x20
# Keyboard 4 and $ - 0x21

# Keyboard a and A - 0x04
# Keyboard b and B - 0x05
# Keyboard c and C - 0x06
# Keyboard d and D - 0x07
# Keyboard e and E - 0x08
# Keyboard f and F - 0x09
# Keyboard g and G - 0x0A
# Keyboard h and H - 0x0B
# Keyboard i and I - 0x0C
# Keyboard j and J - 0x0D
# Keyboard k and K - 0x0E
# Keyboard l and L - 0x0F
# Keyboard m and M - 0x10
# Keyboard n and N - 0x11
# Keyboard o and O - 0x12
# Keyboard p and P - 0x13
# Keyboard q and Q - 0x14
# Keyboard r and R - 0x15
# Keyboard s and S - 0x16
# Keyboard t and T - 0x17
# Keyboard u and U - 0x18
# Keyboard v and V - 0x19
# Keyboard w and W - 0x1A
# Keyboard x and X - 0x1B
# Keyboard y and Y - 0x1C
# Keyboard z and Z - 0x1D

# reset keymaps to defaults, useful when switching keyboards
# hidutil property --set '{ "UserKeyMapping": [ ] }'

