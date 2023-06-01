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
set scl=yes         " Set signcolumn for LSP information

set diffopt+=vertical     " Diffs always vertical
set fileformats=unix,dos  " Windows bad.

" use filetype.lua instead of filetype.vim
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

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
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'kevinoid/vim-jsonc'

" Navigation
Plug 'jremmen/vim-ripgrep' " Search

" Visual
Plug 'itchyny/lightline.vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ap/vim-buftabline' " Show buffers where the tabline is

" Utility
Plug 'preservim/nerdcommenter' " Toggle comments
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
Plug 'windwp/nvim-autopairs'

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

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils' " Snipmate dep
Plug 'tomtom/tlib_vim'              " Snipmate dep
Plug 'garbas/vim-snipmate'          " Snippet engine
Plug 'honza/vim-snippets'         " Community snippets

Plug 'nvim-lua/plenary.nvim' " Telescope and harpoon
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'ThePrimeagen/harpoon'

" All of your Plugins must be added before the following line
call plug#end()              " required
filetype plugin indent on    " required

" COMMANDS ======================================================

command JsonPretty execute "%!python -m json.tool"
command OpenInExplorer execute "!explorer %:p:h"
command CurFileDir execute "NvimTreeFindFile"
command CopyRelativeFilePath execute "let @* = expand(\"%\")"
command! BufCleanup execute 'call DeleteEmptyBuffers()'
command! BufOnly execute '%bdelete|edit #|call DeleteEmptyBuffers()|normal `"'
command! -bar Lint execute 'Prettier' | execute 'EslintFixAll'
command HarpoonFile execute 'lua require("harpoon.mark").add_file()'
command -bar NgTemplate execute 'let template_file = expand("%:r")..".html"' | execute 'edit' template_file
command -bar NgStyle execute 'let style_file = expand("%:r")..".scss"' | execute 'edit' style_file

" KEYMAPS =======================================================
<<<<<<< HEAD
" <silent> is a map modifier, which won't show the actual input.
=======
>>>>>>> bd8be1cb287a2aa026b59a22565955cd17637deb
" Unbind F1
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" Buffer nav
nmap <silent><C-l> :bn<Cr>
nmap <silent><C-h> :bp<Cr>
nnoremap <silent><C-X> :bd<CR>

nmap <leader>ff :NvimTreeOpen<Cr>

" file picker
nnoremap <C-P> <cmd>Telescope find_files<cr>

" <Leader> - backslash by default
" remove trailing spaces in the current buffer
nmap <Leader>t :%s/\s\+$//<Cr>

" Run code inline
nmap <leader>ts :w !ts-node<Cr>
nmap <leader>js :w !node<Cr>

" format json (jq '.' on unix-like)
nmap <leader>jq :%!jq .<Cr>

" Search word under cursor with ripgrep
nmap <Leader>f :Rg<Cr>

" Copy to clipboard
vmap <leader>y  "+y
nmap <leader>Y  "+yg_
nmap <leader>y  "+y
nmap <leader>yy  "+yy

" Paste from clipboard
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Misc
tnoremap <Esc><Esc> <C-\><C-n> " Exit terminal mode when developer panics

" Buffer stuff
" Search for selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Harpoon
nmap <silent><C-E> :lua require("harpoon.ui").toggle_quick_menu()<CR>

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

" NERDCOMMENTER defaults
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Remove toolbars and scrollbars.
set guifont=Hasklig:h18  " unused in nvim-qt, use ginit.vim (see below)
set guioptions-=m        " menu bar
set guioptions-=T        " toolbar
set guioptions-=r        " scrollbar

" use Prettier where config preset
" let g:prettier#autoformat_config_present = 1

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
      \ 'colorscheme': 'tokyonight',
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

" There are also colorschemes for the different styles
" colorscheme tokyonight-night
" colorscheme tokyonight-storm
" colorscheme tokyonight-day
" colorscheme tokyonight-moon
colorscheme tokyonight-day
set background=light

" Surround options (decimals equal to ASCII codes and '\r' is the text to be
" surrounded)
let g:surround_40 = "(\r)"
let g:surround_91= "[\r]"

" Snipmate
let g:snipMate = { 'snippet_version' : 1 }
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Vimwiki settings - path and set to markdown mode.
let g:vimwiki_list = [{'path': 'C:\Users\rp\vimwiki', 'syntax': 'markdown', 'ext': '.wiki'}]

" Remove trailing spaces before save
autocmd BufWritePre * %s/\s\+$//e

" Only show buffer tabline if there is more than 1 buffer opened
let g:buftabline_show = 1

function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

" Godot
func! GodotSettings() abort
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

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local servers = { 'tsserver', 'eslint', 'graphql', 'nxls' }
local nvim_lsp = require('lspconfig')
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

-- START NVIM-TREE SETUP
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- use defaults for nvim autoparis
require("nvim-autopairs").setup {}
-- END NVIM-TREE SETUP
EOF
