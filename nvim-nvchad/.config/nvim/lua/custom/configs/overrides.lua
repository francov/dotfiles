local function copy_file_to(node)
	local file_src = node["absolute_path"]
	-- The args of input are {prompt}, {default}, {completion}
	-- Read in the new file path using the existing file's path as the baseline.
	local file_out = vim.fn.input("COPY TO: ", file_src, "file")
	-- Create any parent dirs as required
	local dir = vim.fn.fnamemodify(file_out, ":h")
	vim.fn.system({ "mkdir", "-p", dir })
	-- Copy the file
	vim.fn.system({ "cp", "-R", file_src, file_out })
end

local M = {}

M.treesitter = {
	ensure_installed = {
		"json",
		"json5",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"c",
		"cpp",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",
		"pyright",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		"eslint_d",
		"emmet-ls",

		-- C/C++
		"clangd",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	filters = {
		dotfiles = true,
	},

	renderer = {
		highlight_git = true,
		highlight_opened_files = "name",
		icons = {
			show = {
				folder = false,
				file = false,
				git = true,
			},
		},
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "c", function()
			local node = api.tree.get_node_under_cursor()
			local file_src = node["absolute_path"]
			-- The args of input are {prompt}, {default}, {completion}
			-- Read in the new file path using the existing file's path as the baseline.
			local file_out = vim.fn.input("COPY TO: ", file_src, "file")
			-- Create any parent dirs as required
			local dir = vim.fn.fnamemodify(file_out, ":h")
			vim.fn.system({ "mkdir", "-p", dir })
			-- Copy the file
			vim.fn.system({ "cp", "-R", file_src, file_out })
		end, opts("copy_file_to"))
	end,
}

M.blankline = {
	show_current_context = false,
	show_current_context_start = false,
}

M.trouble = {
	icons = false,
}

M.ts_autotag = {
	autotag = {
		enable = true,
	},
}

M.session_manager = function()
	require("session_manager").setup({
		autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
		autosave_last_session = true,
		autosave_ignore_not_normal = true,
		autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
			"lazygit",
			"gitcommit",
			"gitrebase",
		},
	})
end

return M
