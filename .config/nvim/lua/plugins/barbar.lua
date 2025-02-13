
--================--
--   Keymappings  --
--================--

-- Magic buffer-picking mode
vim.keymap.set("n", "<leader>bb", ":BufferPick<cr>", { noremap=true, silent=true })

-- Sort automatically by...
vim.keymap.set("n", "<leader>bd", ":BufferOrderByDirectory<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<leader>bl", ":BufferOrderByLanguage<cr>", { noremap=true, silent=true })

-- Move to previous/next
vim.keymap.set("n", "<M-,>", ":BufferPrevious<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-.>", ":BufferNext<cr>", { noremap=true, silent=true })

-- Re-order to previous/next
vim.keymap.set("n", "<leader>,", ":BufferMovePrevious<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<leader>.", ":BufferMoveNext<cr>", { noremap=true, silent=true })

-- Goto buffer in position...
vim.keymap.set("n", "<M-1>", ":BufferGoto 1<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-2>", ":BufferGoto 2<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-3>", ":BufferGoto 3<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-4>", ":BufferGoto 4<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-5>", ":BufferGoto 5<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-6>", ":BufferGoto 6<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-7>", ":BufferGoto 7<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-8>", ":BufferGoto 8<cr>", { noremap=true, silent=true })
vim.keymap.set("n", "<M-9>", ":BufferLast<cr>", { noremap=true, silent=true })

-- Close buffer
vim.keymap.set("n", "<leader>bk", ":BufferClose<cr>", { noremap=true, silent=true })

-- Wipeout buffer
--                          :BufferWipeout<CR>

-- Close commands
vim.keymap.set("n", "<leader>bak", ":BufferCloseAllButCurrent<cr>", { noremap=true, silent=true })
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

