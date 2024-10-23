local M = {}

M.treesitter = {
  ensure_installed = {
    "comment",
    "vimdoc",
    "luadoc",
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
        file = true,
        git = true,
      },
    },
  },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
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
      vim.fn.system { "mkdir", "-p", dir }
      -- Copy the file
      vim.fn.system { "cp", "-R", file_src, file_out }
    end, opts "copy_file_to")
  end,
}

M.blankline = {
  scope = {
    show_start = false,
    show_end = false,
  },
}

M.ts_autotag = {
  autotag = {
    enable = true,
  },
}

M.session_manager = function()
  require("session_manager").setup {
    autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
    autosave_last_session = true,
    autosave_ignore_not_normal = true,
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
      "lazygit",
      "gitcommit",
      "gitrebase",
    },
  }
end

M.mini_comment = {
  options = {
    custom_commentstring = function()
      return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
    end,
  },
  mappings = {
    -- Normal and Visual modes
    comment = "<C-c>",
    -- Toggle comment on current line
    comment_line = "<C-c>",
    -- Toggle comment on visual selection
    comment_visual = "<C-c>",
    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    -- Works also in Visual mode if mapping differs from `comment_visual`
    textobject = "gc",
  },
}

M.cmp = {
  -- preselect = cmp.PreselectMode.None,
  sources = {
    { name = "codeium" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
  },
}

return M
