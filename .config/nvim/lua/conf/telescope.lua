--================--
--   Telescope config  --
--================--

require('telescope').setup()
pcall(require('telescope').load_extension, 'fzf')

--================--
--   Keymappings  --
--================--

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fF', "<cmd>lua require('telescope.builtin').find_files({ hidden=true })<cr>", { desc = '[F]ind hidden [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {  desc = '[F]ind by [G]rep in Git' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
