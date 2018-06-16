set nocompatible              " be iMproved, required
set nu  		      " show those line numbers

" Tab settings, 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" When adding a plugin,
" run ':source %' and ':PluginInstall'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Tim Pope goodies
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

" Git Wrapper, provides :Gcommit, :Gstatus, :Gdiff, :Gdiff, etc.
" and status line for VIM airline
Plugin 'tpope/vim-fugitive' 

" Auto completion engine
" For nvim it needs python support. See :checkhealth
" For nvim on arch linux - install via pacman 'sudo pacman -S python-neovim'
" For rust and javascript support, additional install steps are required
" See full installation guide at https://github.com/Valloric/YouCompleteMe#full-installation-guide
Plugin 'Valloric/YouCompleteMe'

" Syntax highlight
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'

" Navigation
Plugin 'kien/ctrlp.vim' "Ctrl+P File finder
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin' " Git status indicators for nerdtree

" Syntax Check
Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'

" Visual
Plugin 'bling/vim-airline'
Plugin 'vim-gitgutter'

" Utility
Plugin 'terryma/vim-multiple-cursors' " Sublime text-like multiple cursors
Plugin 'scrooloose/nerdcommenter' " Toggle comments

" VimWiki
Plugin 'vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable omnicomplete (requires set plugin on)
set omnifunc=syntaxcomplete#Complete

" Add LESS filetype which doesn't work for me for some reason.
au BufRead,BufNewFile *.less		setfiletype less

" Commands
command -nargs=1 Rf YcmCompleter RefactorRename <args> " :Rf new_variable_name (js and ts only)

" Set keymaps
" Quicksave
nmap <F2> :w<Cr>
imap <F2> <Esc>:w<Cr>

" Toogle NERD tree
nmap <F3> :NERDTreeToggle<Cr>

" Go to symbol doc
nmap <F4> :YcmCompleter GetDoc<Cr>

" Show symbol type
nmap <F5> :YcmCompleter GetType<Cr>
imap <F5> <Esc>:YcmCompleter GetType<Cr>

" shift+tab for inverse tabbing
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" Go go definition
nmap <C-b> :YcmCompleter GoTo<Cr>

" <Leader> - backslash by default
" remove trailing spaces in the current buffer
nmap <Leader>t :%s/\s\+$//<Cr>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Enable 256 color support and load colorscheme
set t_Co=256
let g:rehash256 = 1

" Enable TrueColor
set termguicolors

" Remove toolbars and scrollbars.
set guifont=Hack\ 12
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

" Set theme and background depending of time of day
let hour = strftime("%H")
if 6 <= hour && hour < 14
    colorscheme material-theme
    set background=dark
else
    colorscheme material-theme
    set background=dark
endif

" Enable powerline symbols
let g:airline_powerline_fonts = 1

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_rust_checkers = ['cargo']

" YouCompleteMe settings
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_goto_buffer_command = 'new-tab'

" Rename tabs to show tab number and show loaded files in tooltips.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    " Append the tab number
    let label .= v:lnum.': '
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        " get only the file name
        let name = fnamemodify(name,":t")
    endif
    let label .= name
    " Append the number of windows in the tab page
    let wincount = tabpagewinnr(v:lnum, '$')
    return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}
