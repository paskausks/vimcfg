# 📜 .vimrc

My daily-driver nvim configuration.

## Requirements

* [Neovim](https://neovim.io/) >= 0.5.0
* [Plug](https://github.com/junegunn/vim-plug)
* The [Monoid](https://larsenwork.com/monoid/) font (for _nvim-qt_).

## Installation

Clone/copy the repo contents in:

* Unix - _~/.config/nvim/init.vim_ (or init.lua)
* Windows - _~/AppData/Local/nvim/init.vim_ (or init.lua)
* or if `$XDG_CONFIG_HOME` is defined - _$XDG_CONFIG_HOME/nvim/init.vim_ (or init.lua)

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
