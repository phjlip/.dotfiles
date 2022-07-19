--================--
--   Telescope config  --
--================--

require('telescope').setup{}
pcall(require('telescope').load_extension, 'fzf')


--================--
--   Keymappings  --
--================--

vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap=true,silent=true })
vim.keymap.set("n", "<leader>fF", "<cmd>lua require('telescope.builtin').find_files({ hidden=true })<cr>", { noremap=true,silent=true })
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap=true,silent=true })
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap=true,silent=true })
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap=true,silent=true })

