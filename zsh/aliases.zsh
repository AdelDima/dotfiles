# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
weather() { curl -4 wttr.in/${1:-antwerp} }
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias zbundle="antibody bundle < $DOTFILES/zsh_plugins.txt > $DOTFILES/zsh_plugins.sh"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel
alias a="php artisan"
alias ams="php artisan migrate:fresh --seed"

# PHP
alias php73="/usr/local/Cellar/php@7.3/7.3.12/bin/php"
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Docker
alias docker-composer="docker-compose"
#alias dstop="docker stop $(docker ps -a -q)"
#alias dpurgecontainers="dstop && docker rm $(docker ps -a -q)"
#alias dpurgeimages="docker rmi $(docker images -q)"
#dbuild() { docker build -t=$1 .; }
#dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

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
alias test="/Volumes/os_hdd/www/test/app/public/wp-content/themes"
alias adeltahri="/Volumes/os_hdd/www/ziro/app/public/adeltahri.dev"

alias noor="/Volumes/os_hdd/www/noor/app/public/wp-content/themes/noor"
alias noorwp="code /Volumes/os_hdd/www/noor/app/public/wp-content/themes/noor/noor.code-workspace"

alias okab="/Volumes/os_hdd/www/okab/app/public/wp-content/themes/okab"
alias okabwp="code /Volumes/os_hdd/www/okab/app/public/wp-content/themes/okab.code-workspace"

alias noor_a="/Volumes/os_hdd/www/noor/app/public/wp-content/plugins/noor_assistant"
alias okab_a="/Volumes/os_hdd/www/okab/app/public/wp-content/plugins/dima_shortcodes"
alias okab_p="/Volumes/os_hdd/www/okab/app/public/wp-content/plugins/dima-portfolio"

alias dima_api="/Volumes/os_hdd/www/ziro/app/public/aws-update"
alias noor_data="/Volumes/os_hdd/www/noor-data"

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
