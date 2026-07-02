# elvisgastelum/easy-nvim

Easy is my personal lua config, which I don't want to write twice.

## Configuration profiles

This repo supports loading config profiles (`dev`, `stable`, or new ones under `lua/{name}`).

- See `docs/CONFIGURATION-LOADER.md` for setup, `:ConfigSet`, and profile rules.

## Instalation

### Global Intallation (Recommended)

```sh
git clone git@github.com:elvisgastelum/easy-nvim.git ~/.config/nvim
```

### Scoped Installation (Experimental)

Clone repo

```sh
git clone git@github.com:elvisgastelum/easy-nvim.git ~/.config/easy-nvim
```

Set NVIM_APPNAME to use scoped installation instead of global

```
export NVIM_APPNAME=easy-nvim
```

## Dependencies

### MacOS

I recommend to install brew for easy installation packages

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

install neovim (v0.11.0):

```sh
brew install bob
bob install 0.11.0
bob use 0.11.0
```

install NodeJS

```sh
brew install fnm
fnm use v22.14.0
npm install -g neovim
```

install fzf:

```sh
brew install fzf
```

download the latest command line tools for xcode

- [https://developer.apple.com/download/all/?q=command%20line%20tools](https://developer.apple.com/download/all/?q=command%20line%20tools)

install gcc (dependency required by Neorg plugin for mac users)

```sh
brew install gcc@12
```

set CC environment variable on your rc or profile file, my personal preference is ~/.zprofile
because I use zsh

```sh
export CC=$(brew --prefix gcc@12)/bin/gcc-12
```

Depending on your instalation, always you can know with

```sh
which gcc-12
```

source file you used to export the environment above

```sh
source ~/.zprofile
```

### Linux (Ubuntu)

Update your system

```sh
sudo apt update
sudo apt upgrade -y
```

General dependencies

```sh
sudo apt install curl unzip git build-essential jq -y
```

Make sure you have clipboard backend installed (Optional)

```sh
sudo apt install xsel -y # on x.org server
sudo apt install wl-clipboard -y # on wayland server
```

Gah, — GitHub Releases App Installer (Linux and macOS)

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/get-gah/gah/refs/heads/master/tools/install.sh)"
```

You can install [lazygit](https://github.com/jesseduffield/lazygit) using [gah](https://github.com/get-gah/gah)

```
gah install lazygit
```

I recommend to install neovim (v0.11.0) with [bob neovim version manager](https://github.com/MordechaiHadad/bob)

```sh
touch ~/.bash_profile
touch ~/.bash_login
curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
bob install 0.11.0
bob use 0.11.0
source ~/.bashrc
```

Install NodeJS using [fnm](https://github.com/Schniz/fnm)

```sh
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm use v22.14.0 --install-if-missing --corepack-enabled
npm install -g neovim
```

Install [fzf](https://github.com/junegunn/fzf):

```sh
sudo apt install fzf -y
```

## Disclaimer

    Since is the config i use personally and mantain for my selft i want to have
    the ability to clone, satisfy dependencies and code with no extra config
    to get started

    Obviusly this is not a config for users new to nvim/vim ecosystem but is not too advance
    because i'm not a expert user, just a person who program for web and like the terminal
    apps.

    I recommend to read the keymaps and options file and modify to suit your requirements
    for now i centralize the things on that files because is more easy to get started the config
    but idk how scalable that is, whatever suggestions are welcome :).

## TODO

- [ ] List all dependencies (download nvim, brew gcc-12 and set CC environment variable, etc.)
  - [x] List all dependencies
  - [ ] List fonts
- [ ] Write a spep by step instalation of this config
