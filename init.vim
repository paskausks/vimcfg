set nocompatible    " no need to cosplay vi

" Tab settings, 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4

" Undo, cache and backup directories.
" Directories have to exist.
set undodir=~/.vim/undo-dir
set undofile
set backupdir=~/.vim/backups
set dir=~/.vim/swap

set showtabline=0   " always show tabs in gvim, but not vim
set colorcolumn=120 " add red column for line limit (probably should be set in ftypes
set scrolloff=8     " minimal number of screen lines to keep above and below the cursor.
set noshowmode      " mode already shown in Lightline.
set ignorecase      " ignore case in searches.
set nohlsearch      " don't highlight search results.
set incsearch       " While typing a search command, show where the pattern, as it was typed so far, matches
set rnu nu          " hybrid line number mode
set cul             " highlight current line
set nojoinspaces    " Prevents inserting two spaces after punctuation on a join (J)
set splitbelow      " Horizontal split below current.
set splitright      " Vertical split to right of current.
set hidden          " Allow unsaved buffers

set diffopt+=vertical     " Diffs always vertical
set fileformats=unix,dos  " Windows bad.

" set up space as leader key
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

syntax enable
filetype off                  " required

" These patterns don't deserve our love and shouldn't be shown in menus.
" Set search paths in ./after/ftplugin/somefiletypename.vim.
" More in :h ftplugin
set wildignore+=**/node_modules/**,*/dist/*,*/target/*,*/build/*

" PLUGINS =======================================================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" When adding a plugin,
" run ':source %' and ':PlugInstall'
" To update:
" :PlugUpdate
" And to remove unused:
" :PlugClean

" Tim Pope goodies
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" Syntax highlight
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'cespare/vim-toml'
Plug 'kevinoid/vim-jsonc'
Plug 'habamax/vim-godot'

" Navigation
Plug 'jremmen/vim-ripgrep' " Search

" Visual
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'ap/vim-buftabline' " Show buffers where the tabline is

" Utility
Plug 'scrooloose/nerdcommenter' " Toggle comments
Plug 'editorconfig/editorconfig-vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'

" VimWiki
Plug 'vimwiki/vimwiki'
"
" LSP
" npm install -g typescript typescript-language-server
Plug 'neovim/nvim-lspconfig'

" For LSP autocomplete
Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'         " Snippets plugin

" All of your Plugins must be added before the following line
call plug#end()              " required
filetype plugin indent on    " required

" KEYMAPS =======================================================

" Buffer nav
nmap <silent><C-l> :bn<Cr>
nmap <silent><C-h> :bp<Cr>

" <silent> is a map modifier, which won't show the actual input.
nmap <silent><F3> :Vexplore<Cr>

" telescope
nnoremap <C-P> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" shift+tab for inverse tabbing
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" Go to alternate (previous) file with CTRL+Backspace
" useful with peeking a file with "gf" and then going back.
nmap <C-BS> <C-^>

" <Leader> - backslash by default
" remove trailing spaces in the current buffer
nmap <Leader>t :%s/\s\+$//<Cr>

" Rust stuff
nmap <Leader>b :!cargo build<Cr>
nmap <Leader>bb :!cargo test<Cr>
nmap <Leader>bt :!cargo test <C-R><C-W><Cr> " Runs test under cursor
nmap <Leader>br :!cargo run<Cr>
nmap <Leader>bc :!cargo clippy<Cr>
nmap <Leader>bf :!cargo fmt<Cr>

" Search word under cursor with ripgrep
nmap <Leader>f :Rg<Cr>

" Copy to clipboard
vmap <Bslash>y  "+y
nmap <Bslash>Y  "+yg_
nmap <Bslash>y  "+y
nmap <Bslash>yy  "+yy

" Paste from clipboard
nmap <Bslash>p "+p
nmap <Bslash>P "+P
vmap <Bslash>p "+p
vmap <Bslash>P "+P

" Misc
imap jj <ESC>
imap <C-/> <ESC><plug>NERDCommenterToggle
vmap <C-/> <plug>NERDCommenterToggle
nmap <C-/> <plug>NERDCommenterToggle
tnoremap <Esc><Esc> <C-\><C-n> " Exit terminal mode when developer panics

" Buffer stuff
" Search for selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Print a numbered list of buffers. Type respective number to go to filename
nnoremap <F5> :buffers<CR>:buffer<Space>

" Close buffer on double Backspace
nnoremap <BS><BS> :bd<CR>

" Save and close buffer
command WQ execute "w|bd"

" Save with ctrl+S
nmap <C-s> :w<CR>
vmap <C-s> <ESC>:w<CR>
imap <C-s> <ESC>:w<CR>

" CONFIG =======================================================
" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

" Enable 256 color support and load colorscheme
set t_Co=256
let g:rehash256 = 1

" Enable TrueColor
set termguicolors

" Remove toolbars and scrollbars.
set guifont=Hasklig:h18  " unused in nvim-qt, use ginit.vim (see below)
set guioptions-=m        " menu bar
set guioptions-=T        " toolbar
set guioptions-=r        " scrollbar

""" NVIM-QT NOTES """
" To remove the QT toolbar on windows for nvim-qt, go to the registry:
" Computer\HKEY_CURRENT_USER\Software\nvim-qt\nvim-qt
" and set "ext_tabline" to "false"
"
" source: https://github.com/equalsraf/neovim-qt/issues/589
"
" Sample ginit.vim
" if exists('g:GuiLoaded')
"    GuiFont! hasklig:h12
"    GuiLinespace 4
" endif

" Set Lightline colorscheme.
" Call before setting editor scheme.
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

colorscheme gruvbox
set background=dark

" Surround options (decimals equal to ASCII codes and '\r' is the text to be
" surrounded)
let g:surround_40 = "(\r)"
let g:surround_91= "[\r]"

" Vimwiki settings - path and set to markdown mode.
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]

" Remove trailing spaces before save
autocmd BufWritePre * %s/\s\+$//e

" Only show buffer tabline if there is more than 1 buffer opened
let g:buftabline_show = 1

" Close all buffers except the current one
command! BufOnly execute '%bdelete|edit #|normal `"'

" Open a terminal in a split
command! VT execute 'vs|terminal'
command! HT execute 'split|terminal'

" When shift finger fat
command! Q execute 'q'

" Godot
func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end

" nvim lsp stuff
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- BEGIN AUTOCOMPLETE SETUP
-- Autocompletion is expensive. In order to provide completion, text must be synchronized on each completion request,
-- and autocompletion plugins often send multiple completion requests per second to the language server as you type.
-- If you notice slowdowns, the most likely candidate is your autocompletion plugin, or the language server which
-- is bottlenecking it.

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'

local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(core, fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      elseif not check_back_space() then
        cmp.mapping.complete()(core, fallback)
      else
        vim.cmd(':>')
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        vim.cmd(':<')
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- END AUTOCOMPLETE SETUP
EOF
