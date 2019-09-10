#!/bin/bash
TEST=~/Library/Application\ Support/Firefox/Profiles/`ls -rt ~/Library/Application\ Support/Firefox/Profiles/ | tail -1`
ln -s ~/code/dotfiles/user.js "$TEST/user.js"