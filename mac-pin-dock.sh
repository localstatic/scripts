#!/usr/bin/env bash

defaults write com.apple.Dock position-immutable -bool yes
killall Dock
