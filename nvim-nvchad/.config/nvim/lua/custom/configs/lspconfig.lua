local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    -- ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --   signs = {
    --     severity_limit = "Hint",
    --   },
    --   virtual_text = {
    --     severity_limit = "Warning",
    --   },
    -- }),
  },
  -- init_options = {
  --   preferences = {
  --     disableSuggestions = true,
  --   },
  -- },
}

-- lspconfig.emmet_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {
--     "html",
--     "javascript",
--     "javascriptreact",
--     "typescriptreact",
--   },
--   init_options = {
--     js = {
--       options = {
--         ["markup.attributes"] = { class = "className" },
--       },
--     },
--     jsx = {
--       options = {
--         ["markup.attributes"] = { class = "className" },
--       },
--     },
--     html = {
--       options = {
--         -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
--         ["bem.enabled"] = true,
--       },
--     },
--   },
-- }
--
-- lspconfig.pyright.setup { blabla}

-- Ignore some tsserver diagnostics - SEE: https://github.com/LunarVim/LunarVim/discussions/4239
-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
local function filter_tsserver_diagnostics(_, result, ctx, config)
  if result.diagnostics == nil then
    return
  end
  local blacklisted_codes = { [80001] = true }
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
vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
