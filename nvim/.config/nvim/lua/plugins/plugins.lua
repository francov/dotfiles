local overrides = require "configs.overrides"

return {
  {
    "stevearc/conform.nvim",
    event = { "VeryLazy", "BufWritePre" }, -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
      },
    },
    config = function(_, opts)
      local lint = require "lint"
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
        group = vim.api.nvim_create_augroup("Lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- override plugin configs
  { "folke/trouble.nvim", opts = { icons = {} } },
  { "williamboman/mason.nvim", opts = overrides.mason },
  { "nvim-treesitter/nvim-treesitter", dependencies = { "folke/trouble.nvim" }, opts = overrides.treesitter },
  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
  { "lukas-reineke/indent-blankline.nvim", opts = overrides.blankline },
  { "https://github.com/farmergreg/vim-lastplace.git", lazy = false },
  { "mattn/emmet-vim", event = "VeryLazy" },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "echasnovski/mini.comment", event = "VeryLazy", opts = overrides.mini_comment },
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

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   lazy = true,
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --     vim.g.mkdp_refresh_slow = 1
  --   end,
  -- },

  -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  -- DISABLED HERE
  { "NvChad/nvim-colorizer.lua", enabled = false },
}
