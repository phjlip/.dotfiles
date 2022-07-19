--==========================
--|  Neovim Configuration  |
--==========================

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

--============
--| Plugins  |
--============

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                                                    -- Package manager

  -- IDE Things
  use 'nvim-treesitter/nvim-treesitter'                                           -- Highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- Additional textobjects for treesitter
  use 'neovim/nvim-lspconfig'                                                     -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer'                                           -- Automatically install language servers to stdpath
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }               -- Autocompletion
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- Snippet Engine and Snippet Expansion
  -- use 'tpope/vim-fugitive'                                                        -- Git commands in nvim
  -- use 'tpope/vim-rhubarb'                                                         -- Fugitive-companion to interact with github

  -- Text Editing
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-sleuth'                                                          -- Detect tabstop and shiftwidth automatically

  -- Functional
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'folke/which-key.nvim'                                                      -- popup showing keybindings
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  use 'kevinhwang91/rnvimr'                                                       -- ranger integration

  -- Colors
  use 'p00f/nvim-ts-rainbow'
  use 'norcalli/nvim-colorizer.lua'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups
  use 'navarasu/onedark.nvim'                                                     -- Theme inspired by Atom
  use 'lukas-reineke/indent-blankline.nvim'                                       -- Add indentation guides even on blank lines
  use 'kyazdani42/nvim-web-devicons'

  -- UI
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- if (vim.fn.has("termguicolors")) then
vim.api.nvim_set_var("&t_8f", "\\<Esc>[38;2;%lu;%lu;%lum")
vim.api.nvim_set_var("&t_8b", "\\<Esc>[48;2;%lu;%lu;%lum")
vim.o.termguicolors = true
-- else
--   vim.api.nvim_set_option("t_Co", 256)
-- end

vim.wo.relativenumber   = true        -- relative linenumbers
vim.wo.number           = true        -- show current line

vim.o.incsearch         = true        -- incremental search
vim.o.hlsearch          = false       -- highlight search
vim.o.ignorecase        = true        -- Ignore case when searching
vim.o.smartcase         = true        -- Don't ignore case when searching for capital letter

vim.wo.breakindent      = true        -- Continue at indentation level after linebreak
vim.wo.linebreak        = true        -- Breaks line after / before word, not in the middle
vim.o.expandtab         = true        -- Always use spaces

vim.wo.cursorline       = true        -- Highlighting current line

vim.o.mouse             = 'a'         -- mouse support

vim.o.showmode          = false       -- Don't show mode in cmd line

vim.o.completeopt = 'menuone,noselect'  -- Set completeopt to have a better completion experience

vim.o.updatetime = 250                  -- Decrease update time
vim.wo.signcolumn = 'yes'


-- vim.cmd("filetype plugin indent on") -- For Filetypes load specific plugins and indent rules

-- No actions for space leader in modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<ESC><ESC>', ':w<CR>', { noremap = true })
vim.keymap.set('i', '<ESC><ESC>', '<ESC>:w<CR>', { noremap = true })

vim.keymap.set('n', '<C-j>', '}', { noremap = true })
vim.keymap.set('n', '<C-k>', '{', { noremap = true })
vim.keymap.set('v', '<C-j>', '}', { noremap = true })
vim.keymap.set('v', '<C-k>', '{', { noremap = true })

vim.keymap.set('n', '<CR>', 'o<esc>k', { noremap = true })

-- vim.keymap.set('n', '<Leader>dw', ':%s/\s\+$//e<CR><C-o>', { noremap = true })

vim.keymap.set('v', '<C-y>', '"+y', { noremap = true })
-- vim.keymap.set('n', '<C-p>', '"+p', { noremap = true })

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Y yank until the end of line  (note: this is now a default on master)
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Rnvimr
vim.keymap.set('n', '<M-o>', ':RnvimrToggle<CR>', { noremap = true, silent = true })


--===================
--| Plugin Settings |
--===================

require('conf.treesitter')
require('conf.telescope')
require('conf.colorizer')
require('conf.rainbow')
require('conf.lualine.bubbles')
require('conf.barbar')
require('conf.lsp')
require('conf.completion')
require('conf.indent')

require('Comment').setup()

require('onedark').setup{ style = 'darker' }
require('onedark').load()

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require("which-key").setup{}
-- Language specific folding (ToDo Should be off when starting a file)
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
