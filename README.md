# 📜 .vimrc

My daily-driver nvim configuration.

## Requirements

* A recent [Neovim](https://neovim.io/) installation
* [Packer.nvim](https://github.com/wbthomason/packer.nvim)
* cc/gdd/clang/cl/etc. to compile [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) parsers.

## Installation

Clone/copy the repo contents in:

* Unix - _~/.config/nvim/
* Windows - _~/AppData/Local/nvim/_
* or if `$XDG_CONFIG_HOME` is defined - _$XDG_CONFIG_HOME/nvim/_

Create the cache directories:
```sh
mkdir -p ~/.vim/undo-dir
mkdir ~/.vim/backups
mkdir ~/.vim/swap
```

Install plugins:

```vim
:lua require("packer").install()
```

and hack away!
