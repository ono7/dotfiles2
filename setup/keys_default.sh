#!/bin/bash

# reset keymaps to defaults, useful when switching keyboards

hidutil property --set '{ "UserKeyMapping": [ ] }'
