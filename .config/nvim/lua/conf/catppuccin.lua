
--======================--
--   Catppuccin miaow   --
--======================--

require('catppuccin').setup({
  color_overrides = {
    mocha = {
      base = '#111827',
    },
  },
  highlight_overrides = {
    mocha = function(mocha)
      return {
        CursorLineNr = { fg = mocha.yellow },
      }
    end,
  },
})
