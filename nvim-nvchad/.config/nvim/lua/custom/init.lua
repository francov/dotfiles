-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local autocmd = vim.api.nvim_create_autocmd
local disable_matchup_matchparen = function()
	vim.b.matchup_matchparen_enabled = 0
end
autocmd("BufNewFile", { pattern = "*", callback = disable_matchup_matchparen })
autocmd("BufRead", { pattern = "*", callback = disable_matchup_matchparen })

vim.g.mapleader = "\\"
vim.o.scrolloff = 8
vim.o.undofile = false

vim.api.nvim_create_user_command("NextHunk", function()
	require("gitsigns").next_hunk()
end, {})
vim.api.nvim_create_user_command("PrevHunk", function()
	require("gitsigns").prev_hunk()
end, {})
