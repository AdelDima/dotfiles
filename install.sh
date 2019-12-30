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
	curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
	export PATH="/usr/local/bin:$PATH"
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

###############################################################################
# INSTALL: npm packages
###############################################################################
if [ -e $cwd/swag/npm ]; then
	chapter "Installing npm packages…"

	for pkg in $(<$cwd/swag/npm); do
		KEY="${pkg%%::*}"
		VALUE="${pkg##*::}"
		install_npm_packages $KEY $VALUE
	done
fi

# -----------------------------------------------------------------------------
# ZSH
# -----------------------------------------------------------------------------
chapter "Configure ZSH…"

FILE=$HOME/.zshrc
if test -f "$FILE"; then
	print_success_muted ".zshrc already exists."
	if ask "Do you want to reset .zshrc?" Y; then
		step "reset .zshrc…"
		step "1 - Removes old .zshrc…"
		#Removes .zshrc from $HOME (if it exists).
		rm -rf $HOME/.zshrc
		step "2 - ymlinks the .zshrc file from the .dotfiles…"
		# ymlinks the .zshrc file from the .dotfiles.
		ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
		print_success ".zshrc Configured"
	fi
else
	step "1 - ymlinks the .zshrc file from the .dotfiles…"
	# ymlinks the .zshrc file from the .dotfiles.
	ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
	print_success ".zshrc Configured"
fi
step "Installing zsh-autosuggestions…"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/zsh/plugins/zsh-autosuggestions

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------

chapter "Installing Oh My Zsh…"
step "Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
print_in_green "${bold}✓ installed!${normal}\n"

step "Installing spaceship theme for Oh My Zsh…"
customzsh=$HOME/.dotfiles//zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.dotfiles/zsh/themes/spaceship-prompt"
print_in_green "${bold}✓ installed!${normal}\n"
echo $customzsh
ln -s "$customzsh/themes/spaceship-prompt/spaceship.zsh-theme" "$customzsh/themes/spaceship.zsh-theme"

# Symlink the Mackup config file to the home directory.
ln -s ~/.dotfiles/.mackup.cfg ~/.mackup.cfg

if [ -d "$HOME/.zshrc" ]; then
	print_success_muted "Oh My Zsh already installed."
	if ask "You wannt to reinstallit??" Y; then
		step "Installing Oh My Zsh…"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		#Removes .zshrc from $HOME (if it exists).
		rm -rf $HOME/.zshrc
		# ymlinks the .zshrc file from the .dotfiles.
		ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
		# Symlink the Mackup config file to the home directory.
		ln -s ~/.dotfiles/.mackup.cfg ~/.mackup.cfg
		print_success "Oh My Zsh installed! & symlinks Configured"
	fi
fi

#iTerm
chapter "Setup iTerm…"
defaults read com.googlecode.iterm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

NERDFONTS=(
	SpaceMono
	Hack
	AnonymousPro
	Inconsolata
	FiraCode
)
NERDFONTS_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/ryanoasis/nerd-fonts/releases/latest)
NERDFONTS_VERSION=$(get_github_version $NERDFONTS_RELEASE)

step "Installing fonts…"
for font in ${NERDFONTS[@]}; do
	if [ ! -d ~/Library/Fonts/$font ]; then
		printf "${indent}  [↓] $font "
		wget -P ~/Library/Fonts https://github.com/ryanoasis/nerd-fonts/releases/download/$NERDFONTS_VERSION/$font.zip --quiet
		unzip -q ~/Library/Fonts/$font -d ~/Library/Fonts/$font
		print_in_green "${bold}✓ done!${normal}\n"
	else
		print_muted "${indent}✓ $font already installed. Skipped."
	fi
done

# Set macOS preferences
# We will run this last because this will reload the shell
#source .macos

###############################################################################
# OPTIONAL
###############################################################################
chapter "Create directory…"
# This is a default directory for macOS user accounts but doesn't comes pre-installed
DIRECTORIES=(
	$HOME/Projects/PixelDima/{Sites/{OkabWP,NoorWP},api,deploy/{Gitlab/{okab,noor},Themeforest/{okab,noor}}}
	$HOME/Code/{github,test}
)

step "Making directories…"
for dir in ${DIRECTORIES[@]}; do
	mkdir -p $dir
done

###############################################################################
# OPTIONAL: Customizations
###############################################################################
chapter "Adding hot sauce…"
if [ -f "$HOME/.hot-sauce" ]; then
	if ask "Do you want to add hot sauce?" Y; then
		. "$HOME/.hot-sauce"
		printf "\n  You got hot sauce in your bag. 🔥 ${bold}Swag.${normal}\n"
	else
		print_success_muted "Hot sauce declined. Skipped."
	fi
else
	print_warning "No ~/.hot-sauce found. Skipping."
fi

e_lemon_ated
