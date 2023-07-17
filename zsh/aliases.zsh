# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
weather() { curl -4 wttr.in/${1:-antwerp} }
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $HOME/dotfiles"
alias library="cd $HOME/Library"

# PHP
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
alias aliases="code ~/dotfiles/zsh/aliases.zsh"

# Aliases for a few useful commands
alias work=$HOME"/Projects/"

alias adeltahri="/Volumes/os_hdd/www/ziro/app/public/adeltahri.dev"

alias noon=$HOME"/Projects/PixelDima/Sites/thenoon/app/public/wp-content/themes/noon/"

alias noor=$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/themes/noor"
alias noor_a=$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/plugins/noor_assistant"

alias noor5=$HOME"/Projects/PixelDima/Sites/noor5/app/public/wp-content/themes/noor"
alias noor5_a=$HOME"/Projects/PixelDima/Sites/noor5/app/public/wp-content/plugins/noor_assistant"

alias okab=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/themes/okab"

alias okab_a=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/plugins/dima_shortcodes"
alias okab_p=$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/plugins/dima-portfolio"

alias dima_api=$HOME"/Projects/PixelDima/api/pixeldima-api/aws-update"
alias dima_data=$HOME"/Projects/PixelDima/api/noor-data"
alias noor_demos=$HOME"/Projects/PixelDima/api/noor-demos"

alias test=$HOME"/Projects/PixelDima/Sites/TestWP/app/public/wp-content/themes/"

alias ws-noor="code "$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/themes/noor/noor.code-workspace"
alias ws-noor-5="code "$HOME"/Projects/PixelDima/Sites/noor5/app/public/wp-content/themes/noor/noor.code-workspace"
alias ws-okab="code "$HOME"/Projects/PixelDima/Sites/OkabWP/app/public/wp-content/themes/okab/okab.code-workspace"
alias ws-noon="code "$HOME"/Projects/PixelDima/Sites/thenoon/app/public/wp-content/themes/noon/noon.code-workspace"
alias ws-blocks-api="code "$HOME"/Projects/open_s/blocks-api/blocks-api.code-workspace"
alias ws-blocks-ai="code "$HOME"/Projects/PixelDima/Sites/thenoon/app/public/wp-content/plugins/dima-blocks-ai/dima-blocks-ai.code-workspace"
alias ws-nst="code "$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/plugins/noor-starter-templates/noor-starter-templates.code-workspace"
alias ws-dima-elements="code "$HOME"/Projects/PixelDima/Sites/NoorWP/app/public/wp-content/plugins/dima-elements/dima-elements.code-workspace"
# Temporary aliases
alias ws-kadence="code "$HOME"/Projects/PixelDima/Sites/kadence/app/public/wp-content/themes/kadence/kadence.code-workspace"

alias python="python3"
alias pip="pip3"
alias pn="pnpm"

# Git Commit, Add all, and Push — in one step.
# General commit function
function gcap() {
    git add . && git commit -m "$1" && git push
}

# Helper function for generating the commit message
function generate_commit_message() {
    local type=$1; shift
    if [[ $1 = '-s' ]]; then
        local scope=$2; shift 2
        echo "$type($scope): $*"
    else
        echo "$type: $*"
    fi
}

# Build
function gbuild() {
    gcap "$(generate_commit_message "$@" "build")"
}

# Chore
function gchore() {
    gcap "$(generate_commit_message "$@" "chore")"
}

# CI
function gci() {
    gcap "$(generate_commit_message "$@" "ci")"
}

# Docs
function gdocs() {
    gcap "$(generate_commit_message "$@" "docs")"
}

# Feat
function gfeat() {
    gcap "$(generate_commit_message "feat" "$@")"
}

# Fix
function gfix() {
    gcap "$(generate_commit_message "$@" "fix")"
}

# Perf
function gperf() {
    gcap "$(generate_commit_message "$@" "perf")"
}

# Refactor
function grf() {
    gcap "$(generate_commit_message "$@" "refactor")"
}

# Style
function gsty() {
    gcap "$(generate_commit_message "$@" "style")"
}

# Test
function gtst() {
    gcap "$(generate_commit_message "$@" "test")"
}
