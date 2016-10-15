set nocompatible              " be iMproved, required
set nu  		      " show those line numbers

" Tab settings, 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable
filetype off                  " required
filetype plugin on            " for the snippet plugin

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Tim Pope goodies
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

" Navigation
Plugin 'kien/ctrlp.vim' "Ctrl+P File finder
Plugin 'tacahiroy/ctrlp-funky' "Jump to function definitions
Plugin 'scrooloose/nerdtree'

" Syntax highlighting
Plugin 'scrooloose/syntastic'
Plugin 'othree/html5.vim'
Plugin 'groenewege/vim-less'
Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'elzr/vim-json'
Plugin 'isRuslan/vim-es6.git'

" Linting and hinting
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'wookiehangover/jshint.vim' "Requires jshint for nodejs

" Visual
Plugin 'bling/vim-airline'
Plugin 'tomasr/molokai'
Plugin 'summerfruit256.vim'

" Utility
Plugin 'terryma/vim-multiple-cursors'
Plugin 'snipMate' "Conflicts with YouCompleteMe. Remap to something else.

" VimWiki
Plugin 'vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable omnicomplete (requires set plugin on)
set omnifunc=syntaxcomplete#Complete

" Add LESS filetype which doesn't work for me for some reason.
au BufRead,BufNewFile *.less		setfiletype less

let g:snips_author = 'Pundurs'

" Add subversion commit message files to semantic autocomplete ignore list.
let g:ycm_filetype_specific_completion_to_disable = {
            \ 'gitcommit': 1,
            \ 'svn': 1
            \}

" Set keymaps
" Quicksave
nmap <F2> :w<Cr>
imap <F2> <Esc>:w<Cr>

" Toogle NERD tree
nmap <F3> :NERDTreeToggle<Cr>

" shift+tab for inverse tabbing
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" <Leader> - backslash by default
" ctrlp-funky bind
nnoremap <Leader>fu :CtrlPFunky<Cr>

" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" remove trailing spaces in the current buffer
nmap <Leader>t :%s/\s\+$//<Cr>

" Django translation template tags and variables for surround.vim
autocmd FileType htmldjango let b:surround_45 = "{% trans '\r' %}" " yss-
autocmd FileType htmldjango let b:surround_43 = "{% blocktrans %}\r{% endblocktrans %}" " yss+
autocmd FileType htmldjango let b:surround_37 = "{% \r %}" " yss%
autocmd FileType htmldjango let b:surround_123 = "{{ \r }}" " yss{
autocmd FileType htmldjango let b:surround_112 = "<p>\r</p>" " yssp
autocmd FileType htmldjango let b:surround_104 = "<h1>\r</h1>" " yssp
autocmd FileType htmldjango let b:surround_97 = "<a href="">\r</a>" " yssa

" Python custom surrounds
autocmd FileType python let b:surround_40 = "(\r)" " yss(

" Enable 256 color support and load colorscheme
set t_Co=256
let g:rehash256 = 1

" Remove toolbars and scrollbars.
set guifont=Hack
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

" Set theme and background depending of time of day
let hour = strftime("%H")
if 6 <= hour && hour < 14
    colorscheme summerfruit256
    set background=light
else
    colorscheme molokai
    set background=dark
endif

" Enable powerline symbols
let g:airline_powerline_fonts = 1

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
