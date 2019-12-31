# DDF

> DDF (Dima Dotefiles) is a shell script to set up a macOS laptop for WordPress development.

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

## Install

Download the script on your $HOME directory:

```sh
git clone https://github.com/AdelDima/dotfiles.git ~/.dotfiles && cd .dotfiles
```

I created this based on my own preferences; your mileage may vary.

Once the script is done, quit and relaunch Terminal.

It is highly recommended to run the script regularly to keep your computer up to date.

## What it sets up
The setup process will install:

<details>
<summary>Basic tools:</summary>

* [XCode Command Line Tools](https://developer.apple.com/xcode/downloads/) for developer essentials.
* [Oh-My-ZSH](https://github.com/ohmyzsh/ohmyzsh), for a more powerful zsh.
* [Git](https://git-scm.com/) for version control
* [Homebrew](http://brew.sh/) for managing operating system libraries.
</details>

<details>
<summary>Package Managers:</summary>

* [NVM](https://github.com/creationix/nvm/) for managing and installing multiple versions of [Node.js](http://nodejs.org/) and [npm](https://www.npmjs.org/)
* [Yarn](https://yarnpkg.com/en/) for managing JavaScript packages
</details>

<details>
<summary>CLI Tools & Utilities:</summary>

* [Gulp](https://gulpjs.com/) the streaming build system
* [Hub](http://hub.github.com/) for interacting with the GitHub API
* [hugo](https://gohugo.io/), an open-source static site generator
* [ImageMagick](http://www.imagemagick.org/) to create, edit, compose, or convert bitmap images
* [mas](https://github.com/mas-cli/mas) Mac App Store command line interface
</details>

### Apps

<details>
<summary>Productivity</summary>

* [Spark](http://https://sparkmailapp.com/) for a better mail client.
* [Alfred](https://www.alfredapp.com/) for increased productivity and efficiency with macOS.
</details>

<details>
<summary>Development</summary>

* [Dash](https://kapeli.com/dash) offline access to API documentation sets
* [Hyper](https://hyper.is/) for an alternative terminal.
* [ImageOptim](https://imageoptim.com/mac) for image optimization.
* [iTerm](https://www.iterm2.com/) for a better terminal.
* [Virtual Box](https://www.virtualbox.org/) powerful virtualization tool
* [Visual Studio Code](https://code.visualstudio.com/) IDE
</details>

<details>
<summary>Design</summary>

* [Figma](https://www.figma.com/) Figma helps teams create, test, and ship better designs from start to finish.
</details>

<details>
<summary>Communication</summary>

* [Notion](http://www.notion.com/) Figma helps teams create, test, and ship better designs from start to finish.ß
* [Skype](https://www.skype.com/en/) for free calls to friends and family.
* [Slack](https://slack.com/) where work happens.
* [Discord](https://discordapp.com/) like slack.
</details>

<details>
<summary>Utilities</summary>

* [LastPass](https://lastpass.com/) for password management.
* [Dropbox](https://www.dropbox.com) for cloud file storage.
* [Karabiner](https://pqrs.org/osx/karabiner/) for keyboard mapping.
</details>

<details>
<summary>Miscellaneous</summary>

* [Rocket](http://matthewpalmer.net/rocket/) for Slack-like emojis.
* [Spotify](https://www.spotify.com/) for music.
* [VLC](http://www.videolan.org/) for a better media player.
</details>

<details>
<summary>Browsers</summary>

* [Blisk](https://blisk.io/) for cross-device web development.
* [Chrome](https://www.google.com/chrome/browser/desktop/) for fast and free web browsing.
* [Firefox](https://www.mozilla.org/en-US/firefox/new/) for web browsing and testing.
* [TorBrowser](https://www.torproject.org/projects/torbrowser.html.en) for super secret web browsing.
</details>

<sub>See [`swag`](swag) for the full list of apps that will be installed. Adjust it to your personal taste.</sub>

It should take less than 20 minutes to install (depends on your machine).

## 🌶 Just add `~/.hot-sauce`

Your `~/.hot-sauce` is added at the end of the Formation script. Put your customizations there.
For example:

```sh
#!/usr/bin/env bash

SETUP_ROOT=$HOME/.setup

NERDFONTS_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/ryanoasis/nerd-fonts/releases/latest)
NERDFONTS_VERSION=$(get_github_version $NERDFONTS_RELEASE)

DIRECTORIES=(
    $HOME/Desktop/code
    $HOME/Desktop/design
    $HOME/Desktop/*dump
    $HOME/Desktop/GIFs
    $HOME/Desktop/projects
    $HOME/Desktop/screenshots
)

NERDFONTS=(
    SpaceMono
    Hack
    AnonymousPro
    Inconsolata
)

step "Making directories…"
for dir in ${DIRECTORIES[@]}; do
    mkd $dir
done

step "Installing fonts…"
for font in ${NERDFONTS[@]}; do
    if [ ! -d ~/Library/Fonts/$font ]; then
        printf "${indent}  [↓] $font "
        wget -P ~/Library/Fonts https://github.com/ryanoasis/nerd-fonts/releases/download/$NERDFONTS_VERSION/$font.zip --quiet;unzip -q ~/Library/Fonts/$font -d ~/Library/Fonts/$font
        print_in_green "${bold}✓ done!${normal}\n"
    else
        print_muted "${indent}✓ $font already installed. Skipped."
    fi
done
```

Write your customizations such that they can be run safely more than once.
See the `slay` script for examples.

Formation functions such as `step` and `link` can be used in your `~/.hot-sauce`.

## Known Issues
Cask does not recognize applications installed outside of Homebrew Cask – in the case that the script fails, you can either remove the application from the install list or uninstall the application causing the failure and try again.

## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Mina Markham](https://github.com/minamarkham/formation/blob/master/swag/casks)

* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.aliases)

## 📜  License

DDF is customized for my own needs. It is free software, and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE
