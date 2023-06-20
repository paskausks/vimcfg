# 📜 .vimrc

My daily-driver nvim configuration.

## Requirements

* A recent [Neovim](https://neovim.io/) installation
* [Plug](https://github.com/junegunn/vim-plug)
* cc/gdd/clang/cl/etc. to compile [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) parsers.

## Installation

Clone/copy the repo contents in:

* Unix - _~/.config/nvim/
* Windows - _~/AppData/Local/nvim/_
* or if `$XDG_CONFIG_HOME` is defined - _$XDG_CONFIG_HOME/nvim/_ (or init.lua)

Create the cache directories:
```sh
mkdir -p ~/.vim/undo-dir
mkdir ~/.vim/backups
mkdir ~/.vim/swap
```

Install plugins:

```vim
:PlugInstall
:source %
```

and hack away!
