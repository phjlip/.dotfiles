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

  -- Text Editing
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use 'jiangmiao/auto-pairs'
  use { 'kylechui/nvim-surround', tag = "*" }

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

-- Move to previous/next
vim.keymap.set("n", "<M-,>", ":bnext<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-.>", ":bprevious<cr>", { noremap=true, silent=true })

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

--===================
--| Plugin Settings |
--===================


require('Comment').setup()
require('nvim-surround').setup{}
