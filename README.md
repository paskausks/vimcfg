# 📜 .vimrc

My daily-driver vim configuration.

## Requirements

* A modern vim distribution like [Neovim](https://neovim.io/) >= 0.3.0 or [Vim](https://www.vim.org/) >= 8.0.
* [Plug](https://github.com/junegunn/vim-plug)

## Installation

Clone/copy the repo contents in a directory which is in the VIM runtime path

* For vim, it's _~/.vim_. Symlink _.vimrc_ into your `HOME`.
* For Neovim, it's _~/.config/nvim/_.  Symlink _.vimrc_ to _init.vim_.
* For sharing the configuration between Neovim and vim, follow the steps above for vim and consult [this help entry](https://neovim.io/doc/user/nvim.html#nvim-from-vim).

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
