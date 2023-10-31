-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

M.override = {
	Comment = {
		italic = true,
	},

	TbLineBufOn = {
		fg = "#36A3D9",
		bg = "#2B2E34",
		bold = true,
	},

	TbLineBufOnClose = {
		bg = "#2B2E34",
	},
}

M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
