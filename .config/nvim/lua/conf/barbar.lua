
--================--
--   Keymappings  --
--================--

-- Magic buffer-picking mode
vim.api.nvim_set_keymap("n", "<leader>bb", ":BufferPick<cr>", { noremap=true, silent=true })

-- Sort automatically by...
vim.api.nvim_set_keymap("n", "<leader>bd", ":BufferOrderByDirectory<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>bl", ":BufferOrderByLanguage<cr>", { noremap=true, silent=true })

-- Move to previous/next
vim.api.nvim_set_keymap("n", "<leader>,", ":BufferPrevious<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>.", ":BufferNext<cr>", { noremap=true, silent=true })

-- Re-order to previous/next
vim.api.nvim_set_keymap("n", "<leader><", ":BufferMovePrevious<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>>", ":BufferMoveNext<cr>", { noremap=true, silent=true })

-- Goto buffer in position...
vim.api.nvim_set_keymap("n", "<leader>1", ":BufferGoto 1<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>2", ":BufferGoto 2<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>3", ":BufferGoto 3<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>4", ":BufferGoto 4<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>5", ":BufferGoto 5<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>6", ":BufferGoto 6<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>7", ":BufferGoto 7<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>8", ":BufferGoto 8<cr>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<leader>9", ":BufferLast<cr>", { noremap=true, silent=true })

-- Close buffer
vim.api.nvim_set_keymap("n", "<leader>bk", ":BufferClose<cr>", { noremap=true, silent=true })

-- Wipeout buffer
--                          :BufferWipeout<CR>

-- Close commands
vim.api.nvim_set_keymap("n", "<leader>bak", ":BufferCloseAllButCurrent<cr>", { noremap=true, silent=true })
--                          :BufferCloseBuffersLeft<CR>
--                          :BufferCloseBuffersRight<CR>

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used


--============--
--   Config   --
--============--

-- initialize bufferline
vim.cmd("let bufferline = {}")

-- Enable/disable auto-hiding the tab bar when there is a single buffer
vim.cmd("let bufferline.auto_hide = v:true")

