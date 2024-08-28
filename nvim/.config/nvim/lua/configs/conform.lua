local options = {
  formatters_by_ft = {
    lua = { "stylua" },
	  javascript = { "prettier" },
	  javascriptreact = { "prettier" },
	  typescript = { "prettier" },
	  typescriptreact = { "prettier" },
	  vue = { "prettier" },
	  css = { "prettier" },
	  scss = { "prettier" },
	  less = { "prettier" },
	  html = { "prettier" },
	  json = { "prettier" },
	  json5 = { "prettier" },
	  jsonc = { "prettier" },
	  yaml = { "prettier" },
	  markdown = { "prettier" },
	  graphql = { "prettier" },
	  handlebars = { "prettier" },

    python = { "black" },
    cpp = { "clang_format" },
  },

  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 2000
  },

}

return options
