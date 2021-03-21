--====================================--
--   Global Functions and Variables   --
--====================================--

local function tcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab(old, new)
    return vim.fn.pumvisible() == 1 and tcodes(old) or tcodes(new)
end
