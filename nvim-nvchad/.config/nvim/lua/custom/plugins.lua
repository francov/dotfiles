local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{ "folke/trouble.nvim", opts = overrides.trouble },
	{ "williamboman/mason.nvim", opts = overrides.mason },
	{ "nvim-treesitter/nvim-treesitter", enabled = true, opts = overrides.treesitter },
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
	{ "lukas-reineke/indent-blankline.nvim", opts = overrides.blankline },
	{ "https://github.com/farmergreg/vim-lastplace.git", lazy = false },
	{ "mattn/emmet-vim", lazy = false },
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "andymass/vim-matchup", lazy = false },
	{ "windwp/nvim-ts-autotag", lazy = false, opts = overrides.ts_autotag },
	{
		"https://github.com/Shatur/neovim-session-manager.git",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = overrides.session_manager,
	},

	-- DISABLED HERE
	{ "NvChad/nvim-colorizer.lua", enabled = false },
	{ "eandrju/cellular-automaton.nvim", enabled = false, lazy = false },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_refresh_slow = 1
		end,
	},
}

return plugins
