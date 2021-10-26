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

###############################################################################
# Get in Formation!          http://patorjk.com/software/taag/ ( font: Script )
###############################################################################

printf "
   _
  | |
  | |  __   ,_    _  _  _    __, _|_ 🍋  __   _  _
  |/  /  \_/  |  / |/ |/ |  /  |  |  |  /  \_/ |/ |
  |__/\__/    |_/  |  |  |_/\_/|_/|_/|_/\__/   |  |
  |\  ---------------------------------------------
  |/  Cause you slay           [for Zsh 3.2 - 3.9]
╭───────────────────────────────────────────────────╮
│  Okay developers now let's get in ${bold}formation${normal}.      │
│───────────────────────────────────────────────────│
│  Safe to run multiple times on the same machine.  │
│  It ${green}installs${reset}, ${blue}upgrades${reset}, or ${yellow}skips${reset} packages based   │
│  on what is already installed on the machine.     │
╰───────────────────────────────────────────────────╯
   ${dim}$(get_os) $(get_os_version) ${normal} // ${dim}$BASH ${normal} // ${dim}$BASH_VERSION${reset}
"

###############################################################################
# CHECK: Internet
###############################################################################
chapter "Checking internet connection…"
check_internet_connection

###############################################################################
# PROMPT: Password
###############################################################################
chapter "Caching password…"
ask_for_sudo

###############################################################################
# PROMPT: SSH Key
###############################################################################
chapter 'Checking for SSH key…'
ssh_key_setup

###############################################################################
# INSTALL: Dependencies
###############################################################################
chapter "Installing Dependencies…"

# -----------------------------------------------------------------------------
# XCode
# -----------------------------------------------------------------------------
if type xcode-select >&- && xpath=$(xcode-select --print-path) &&
	test -d "${xpath}" && test -x "${xpath}"; then
	print_success_muted "Xcode already installed. Skipping."
else
	step "Installing Xcode…"
	xcode-select --install
	print_success "Xcode installed!"
fi

if [ ! -d "$HOME/.bin/" ]; then
	mkdir "$HOME/.bin"
fi

# -----------------------------------------------------------------------------
# NVM
# -----------------------------------------------------------------------------
if [ -x nvm ]; then
	step "Installing NVM…"
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
	print_success "NVM installed!"
	step "Installing latest Node…"
	nvm install node
	nvm use node
	nvm run node --version
	nodev=$(node -v)
	print_success "Using Node $nodev!"
else
	print_success_muted "NVM/Node already installed. Skipping."
fi

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------
if ! [ -x "$(command -v brew)" ]; then
	step "Installing Homebrew…"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/adeltahri/.zprofile eval "$(/opt/homebrew/bin/brew shellenv)"
	print_success "Homebrew installed!"
else
	print_success_muted "Homebrew already installed. Skipping."
fi

if brew list | grep -Fq brew-cask; then
	step "Uninstalling old Homebrew-Cask…"
	brew uninstall --force brew-cask
	print_success "Homebrew-Cask uninstalled!"
fi

###############################################################################
# UPDATE: Homebrew
###############################################################################
chapter "Reset and Updating Homebrew formulae…"
brew update-reset && brew update

###############################################################################
# INSTALL: brews
###############################################################################
if [ -e $cwd/swag/brews ]; then
	chapter "Installing Homebrew formulae…"

	for brew in $(<$cwd/swag/brews); do
		install_brews $brew
	done
fi

###############################################################################
# UPDATE: Homebrew
###############################################################################
chapter "Updating Homebrew formulae…"
brew update

###############################################################################
# INSTALL: casks
###############################################################################
if [ -e $cwd/swag/casks ]; then
	chapter "Installing apps via Homebrew…"

	for cask in $(<$cwd/swag/casks); do
		install_application_via_brew $cask
	done
fi

###############################################################################
# INSTALL: Fonts
###############################################################################
if [ -e $cwd/swag/fonts ]; then
	chapter "Installing fonts via Homebrew…"
	brew tap homebrew/cask-fonts
	for font in $(<$cwd/swag/fonts); do
		install_font_via_brew $font
	done
fi

###############################################################################
# INSTALL: Mac App Store Apps
###############################################################################
chapter "Installing apps from App Store…"
if [ -x mas ]; then

	print_warning "Please install mas-cli first: brew mas. Skipping."

else

	if [ -e $cwd/swag/apps ]; then
		if mas_setup; then
			# Workaround for associative array in Bash 3
			# https://stackoverflow.com/questions/6047648/bash-4-associative-arrays-error-declare-a-invalid-option
			for app in $(<$cwd/swag/apps); do
				KEY="${app%%::*}"
				VALUE="${app##*::}"
				install_application_via_app_store $KEY $VALUE
			done
		else
			print_warning "Please signin to App Store first. Skipping."
		fi
	fi

fi

###############################################################################
# CLEAN: Homebrew files
###############################################################################
chapter "Cleaning up Homebrew files…"
brew cleanup 2>/dev/null