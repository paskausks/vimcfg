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
Plug 'habamax/vim-godot'

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

" Treesitter
" usage :TSInstall <some_lang>
" will compile a parser dylib
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
" npm install -g typescript typescript-language-server
Plug 'neovim/nvim-lspconfig'

" For LSP autocomplete
Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'         " Snippets plugin
Plug 'hrsh7th/cmp-buffer'       " Buffers as a source
Plug 'onsails/lspkind.nvim'     " Kind icons

Plug 'nvim-lua/plenary.nvim' " Telescope and harpoon
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
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
" <silent> is a map modifier, which won't show the actual input.
" Unbind F1
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" Buffer nav
nmap <silent><C-l> :bn<Cr>
nmap <silent><C-h> :bp<Cr>
nmap <silent><C-Right> :bn<Cr>
nmap <silent><C-Left> :bp<Cr>
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

" luasnip
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'

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

-- BEGIN AUTOCOMPLETE SETUP
-- Autocompletion is expensive. In order to provide completion, text must be synchronized on each completion request,
-- and autocompletion plugins often send multiple completion requests per second to the language server as you type.
-- If you notice slowdowns, the most likely candidate is your autocompletion plugin, or the language server which
-- is bottlenecking it.

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

lspconfig['gdscript'].setup {
    capabilities = capabilities,
    -- requires netcat
    -- for windows, get "ncat" (https://nmap.org/ncat/)
    -- and alias ncat to nc
    cmd = { 'nc', 'localhost', '6005' }
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol'
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
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
-- END NVIM-TREE SETUP

-- use defaults for nvim autoparis
require("nvim-autopairs").setup {}

-- use snipmate snippets with luasnip
require("luasnip.loaders.from_snipmate").lazy_load()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "gdscript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
