--=========================--
--   Indent Line  Config   --
--=========================--

-- vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("indent_blankline").setup {
    show_current_context = true,
}
