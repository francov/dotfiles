-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "ts_ls", "html", "cssls", "clangd", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Customize inline diagnostics
vim.diagnostic.config {
  float = { border = "rounded" },
  virtual_text = false,
}
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  -- SEE: https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/2
  pattern = "*",
  group = "lsp_diagnostics_hold",
  callback = function()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float(0, {
      focusable = false,
      scope = "cursor",
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end,
})

-- Ignore some ts_ls diagnostics - SEE: https://github.com/LunarVim/LunarVim/discussions/4239
-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
local function filter_ts_ls_diagnostics(_, result, ctx, config)
  if result.diagnostics == nil then
    return
  end
  local blacklisted_codes = { [80001] = true, [6133] = true }
  local idx = 1
  while idx <= #result.diagnostics do
    local entry = result.diagnostics[idx]
    if blacklisted_codes[entry.code] then
      table.remove(result.diagnostics, idx)
    else
      idx = idx + 1
    end
  end
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end
vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_ts_ls_diagnostics
