--=======================--
--   Completion Config   --
--=======================--

require('global') -- termcodes

-- Use also when lsp is off for other completion sources
vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab("<C-n>", "<Tab>")', { expr=true, noremap=true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_tab("<C-p>", "<S-Tab>")', { expr=true, noremap=true })

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = string.format("%s%s" ,vim.o.shortmess, "c")

vim.g.chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'ts'}},
  },
}

vim.g.completion_auto_change_source = 1
