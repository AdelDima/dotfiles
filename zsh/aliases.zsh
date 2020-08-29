# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
weather() { curl -4 wttr.in/${1:-antwerp} }
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $HOME/.dotfiles"
alias library="cd $HOME/Library"

# PHP
alias php73="/usr/local/Cellar/php@7.3/7.3.12/bin/php"
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"

# Git
alias commit="git add . && git commit -m"
alias gcommit="git add . && git commit"
alias amend="git commit --amend --no-edit"
alias amendall="git add . && amend"
alias wip="commit wip"
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias resolve="git add . && git commit --no-edit"
alias gl="git log --oneline --decorate --color"
alias nuke="git clean -df && git reset --hard"

alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# Aliases for a few useful commands
alias adeltahri="/Volumes/os_hdd/www/ziro/app/public/adeltahri.dev"

alias noor=$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/themes/noor"
alias noor_a=$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/plugins/noor_assistant"
alias noorwp="code "$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/themes/noor/noor.code-workspace"

alias okab=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/themes/okab"
alias okabwp="code "$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/themes/okab.code-workspace"
alias okab_a=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/plugins/dima_shortcodes"
alias okab_p=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/plugins/dima-portfolio"

alias dapi=$HOME"/Projects/PixelDima/api/pixeldima-api/aws-update"
alias noor_data=$HOME"/Projects/PixelDima/api/noor-data"

alias test=$HOME"/Projects/PixelDima/Sites/TestWP/app/public/wp-content/themes/"


# Git Commit, Add all, and Push — in one step.
function gcap() {
	git add . && git commit -m "$*" && git push
}

# NEW.
function gnew() {
	gcap "📦 NEW: $@"
}

# IMPROVE.
function gimp() {
	gcap "👌 IMPROVE: $@"
}

# FIX.
function gfix() {
	gcap "🐛 FIX: $@"
}

# RELEASE.
function grlz() {
	gcap "🚀 RELEASE: $@"
}

# DOC.
function gdoc() {
	gcap "📖 DOC: $@"
}

# TEST.
function gtst() {
	gcap "✅ TEST: $@"
}
