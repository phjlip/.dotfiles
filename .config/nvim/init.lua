--==========================
--|  Neovim Configuration  |
--==========================

-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_var("&t_8f", "\\<Esc>[38;2;%lu;%lu;%lum")
vim.api.nvim_set_var("&t_8b", "\\<Esc>[48;2;%lu;%lu;%lum")
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- IDE Things
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Text Editing
  { 'numToStr/Comment.nvim', opts = {} },                       -- "gc" to comment visual regions/lines
  { 'kylechui/nvim-surround', version = "*", opts = {} },
  'jiangmiao/auto-pairs',
  'tpope/vim-sleuth',

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- Functional
  { 'folke/which-key.nvim', opts = {} },                       -- popup showing keybindings
  { 'kevinhwang91/rnvimr' },                                   -- ranger integration

  -- Bling
  { 'norcalli/nvim-colorizer.lua', opts = {} },

  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  { 'kyazdani42/nvim-web-devicons' },

  -- require 'conf.gitsigns',
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },

  -- UI
  { 'romgrk/barbar.nvim', opts = {} },
  { 'nvim-lualine/lualine.nvim', opts = {} },
}, {})

vim.api.nvim_set_var("&t_8f", "\\<Esc>[38;2;%lu;%lu;%lum")
vim.api.nvim_set_var("&t_8b", "\\<Esc>[48;2;%lu;%lu;%lum")
vim.o.termguicolors = true

vim.wo.relativenumber   = true        -- relative linenumbers
vim.wo.number           = true        -- show current line

vim.o.incsearch         = true        -- incremental search
vim.o.hlsearch          = false       -- highlight search
vim.o.ignorecase        = true        -- Ignore case when searching
vim.o.smartcase         = true        -- Don't ignore case when searching for capital letter

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

vim.keymap.set('n', '<Leader>ws', ':split<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>wh', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<Leader>wj', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<Leader>wk', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<Leader>wl', '<C-w>l', { noremap = true })

vim.keymap.set('n', '<CR>', 'o<esc>k', { noremap = true })

-- vim.keymap.set('n', '<Leader>dw', ':%s/\s\+$//e<CR><C-o>', { noremap = true })

vim.keymap.set('v', '<C-y>', '"+y', { noremap = true })
-- vim.keymap.set('n', '<C-p>', '"+p', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
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
require('conf.barbar')
require('conf.lsp')
require('conf.completion')
require('conf.indent')
require('conf.lualine.evilline_tundra')
require('conf.catppuccin')

vim.opt.background = 'dark'
vim.cmd('colorscheme catppuccin-mocha')
