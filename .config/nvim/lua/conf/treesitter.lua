--======================--
--   Treesitter Config  --
--======================--

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,                  -- false will disable the whole extension
  },
  indent = {
    enable = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  rainbow = {
    enable = true,
    disable = {'bash'}              -- please disable bash until I figure #1 out
  }
--  playground = {
--    enable = true,
--    disable = {},
--    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--    persist_queries = false -- Whether the query persists across vim sessions
--  },
--  query_linter = {
--    enable = true,
--    use_virtual_text = true,
--    lint_events = {"BufWrite", "CursorHold"},
--  },
}
