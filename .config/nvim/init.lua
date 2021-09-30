--==========================
--|  Neovim Configuration  |
--==========================

-- Leader Key
vim.g.mapleader = " "

if (vim.fn.has("termguicolors")) then
    vim.api.nvim_set_var("&t_8f", "\\<Esc>[38;2;%lu;%lu;%lum")
    vim.api.nvim_set_var("&t_8b", "\\<Esc>[48;2;%lu;%lu;%lum")
    vim.api.nvim_set_option("termguicolors", true)
else
    vim.api.nvim_set_option("t_Co", 256)
end

vim.bo.autoindent       = true		-- Like it sounds
vim.bo.cindent          = true   	-- Indentation for C
vim.bo.smartindent      = true  	-- Special Indentation?

vim.bo.tabstop          = 4     	-- show existing tab with 4 spaces width
vim.bo.shiftwidth       = 0     	-- when indenting with '>', use 4 spaces width
vim.bo.softtabstop      = -1     	-- 4 is default with treesitter
vim.bo.expandtab        = true  	-- On pressing tab, insert 4 spaces

vim.wo.relativenumber   = true  	-- relative linenumbers
vim.wo.number           = true  	-- show current line

vim.o.incsearch         = true  	-- incremental search
vim.o.hlsearch          = false 	-- highlight search
vim.o.ignorecase        = true  	-- Ignore case when searching
vim.o.smartcase         = true  	-- Don't ignore case when searching for capital letter

vim.wo.breakindent      = true  	-- Continue at indentation level after linebreak
vim.wo.linebreak        = true  	-- Breaks line after / before word, not in the middle

vim.wo.cursorline       = true  	-- Highlighting current line

vim.o.mouse             = 'a'   	-- mouse support

vim.o.showmode          = false 	-- Don't show mode in cmd line

-- vim.cmd("filetype plugin indent on") -- For Filetypes load specific plugins and indent rules

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--============
--| Plugins  |
--============

-- FIXME: watch out for auto pair plugin in lua
vim.api.nvim_exec(
[[
call plug#begin('~/.config/nvim/plugged')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'tjdevries/colorbuddy.vim'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'romgrk/barbar.nvim'
    Plug 'b3nj5m1n/kommentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()
]],
true)


--===================
--| Plugin Settings |
--===================

require('conf.treesitter')
require('conf.telescope')
require('conf.colorbuddy')
require('conf.colorizer')
require('conf.rainbow')
require('conf.galaxyline.eviline')
require('conf.barbar')
require('conf.lsp')
require('conf.completion')
require('conf.indent')

-- Language specific folding (ToDo Should be off when starting a file)
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
