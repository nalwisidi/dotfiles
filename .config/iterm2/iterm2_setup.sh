#!/bin/sh

###################################################################
# ----------------- iTerm2 Configuration Setup ------------------ #
#                                                                 #
# Customized iTerm2 settings for optimized workflow and display.  #
#                                                                 #
# Author: Nawaf Alwisidi                                          #
###################################################################

# Enable alternate mouse scroll
defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true

# Disable press-and-hold for individual character typing
defaults write com.googlecode.iterm2 ApplePressAndHoldEnabled -bool false

# Set ASCII and Non-ASCII fonts
defaults write com.googlecode.iterm2 "Normal Font" -string "JetBrainsMonoNFM-Regular 14"
defaults write com.googlecode.iterm2 "Non Ascii Font" -string "SymbolsNF 14"

# Set UTF-8 character encoding
defaults write com.googlecode.iterm2 "Character Encoding" -int 4

# Configure Option key behavior
defaults write com.googlecode.iterm2 "Option Key Sends" -int 0
defaults write com.googlecode.iterm2 "Right Option Key Sends" -int 0

# Set columns and rows for terminal size
defaults write com.googlecode.iterm2 Columns -int 190
defaults write com.googlecode.iterm2 Rows -int 50

# Set scrollback line limit
defaults write com.googlecode.iterm2 "Scrollback Lines" -int 1000

# Set terminal transparency
defaults write com.googlecode.iterm2 Transparency -float 0.098