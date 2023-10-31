local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "ayu_dark",
	theme_toggle = { "ayu_dark", "one_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,
	statusline = {
		theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
		overriden_modules = function()
			return {
				-- add parent dir to filename
				fileInfo = function()
					local icon = " 󰈚 "
					local filename = (vim.fn.expand("%") == "" and "Empty ")
						or vim.fn.expand("%:p:h:t") .. "/" .. vim.fn.expand("%:t")
					if filename ~= "Empty " then
						local devicons_present, devicons = pcall(require, "nvim-web-devicons")

						if devicons_present then
							local ft_icon = devicons.get_icon(filename)
							icon = (ft_icon ~= nil and " " .. ft_icon) or ""
						end

						filename = " " .. filename .. " "
					end
					return "%#StText# " .. icon .. filename
				end,
			}
		end,
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
