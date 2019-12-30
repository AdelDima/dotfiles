#!/usr/bin/env bash

# Display message 'Setting up your Mac...'

###############################################################################
# ERROR: Let the user know if the script fails
###############################################################################

trap 'ret=$?; test $ret -ne 0 && printf "\n   \e[31m\033[0m  Formation failed  \e[31m\033[0m\n" >&2; exit $ret' EXIT

set -e

###############################################################################
# HELPER: Check for required functions file
###############################################################################

if [ -e helper ]; then
	cd "$(dirname "${BASH_SOURCE[0]}")" &&
		. "helper"
else
	printf "\n ⚠️  ./helper not found  💃🏾 First, you need to helper on your haters\n"
	exit 1
fi
# -----------------------------------------------------------------------------
# Test
# -----------------------------------------------------------------------------
if [ -d "$HOME/.zshrc" ]; then
	print_success_muted "Oh My Zsh already installed."
	if ask "You wannt to reinstallit??" Y; then
		step "Installing Oh My Zsh…"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		#Removes .zshrc from $HOME (if it exists).
		rm -rf $HOME/.zshrc
		# ymlinks the .zshrc file from the .dotfiles.
		cp -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
		# Symlink the Mackup config file to the home directory.
		ln -s ~/.dotfiles/.mackup.cfg ~/.mackup.cfg
		print_success "Oh My Zsh installed! & symlinks Configured"
	fi
fi