require "nvchad.options"

local autocmd = vim.api.nvim_create_autocmd
local disable_matchup_matchparen = function()
	vim.b.matchup_matchparen_enabled = 0
end

autocmd("BufNewFile", { pattern = "*", callback = disable_matchup_matchparen })
autocmd("BufRead", { pattern = "*", callback = disable_matchup_matchparen })

vim.api.nvim_create_user_command("NextHunk", function()
	require("gitsigns").next_hunk()
end, {})
vim.api.nvim_create_user_command("PrevHunk", function()
	require("gitsigns").prev_hunk()
end, {})

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
