# 📜 init.lua

My daily-driver nvim configuration.

## Requirements

* A recent [Neovim](https://neovim.io/) installation
* cc/gdd/clang/cl/etc. to compile [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) parsers and [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md), probably available via a package manager.

## Installation

Clone/copy the repo contents in:

* Unix - `~/.config/nvim/`
* Windows - `~/AppData/Local/nvim/`
* or if `$XDG_CONFIG_HOME` is defined - `$XDG_CONFIG_HOME/nvim/`

Create the cache directories:
```sh
mkdir -p ~/.vim/undo-dir
mkdir ~/.vim/backups
mkdir ~/.vim/swap
```

Run and hack away!
