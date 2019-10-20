set nocompatible    " be iMproved, required
set nu              " show those line numbers
set cul             " highlight current line

" Tab settings, 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable
filetype off                  " required

" Ale settings
" If something seems to not be working, "ALEInfo" is your friend.
let g:ale_completion_enabled = 1

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

" Lint and auto completion engine
" Zero configuration requirec, but
" see README for language specifics
Plugin 'w0rp/ale'

" Syntax highlight
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'

" Navigation
Plugin 'kien/ctrlp.vim' "Ctrl+P File finder
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin' " Git status indicators for nerdtree

" Visual
Plugin 'bling/vim-airline'

" Utility
Plugin 'terryma/vim-multiple-cursors' " Sublime text-like multiple cursors
Plugin 'scrooloose/nerdcommenter' " Toggle comments

" VimWiki
Plugin 'vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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

" Misc
imap jj <ESC>

" Enable 256 color support and load colorscheme
set t_Co=256
let g:rehash256 = 1

" Enable TrueColor
set termguicolors

" Remove toolbars and scrollbars.
set guifont=Hasklig\ 12
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

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
