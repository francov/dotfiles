-- NOTE: If NvChad hasn't updated its core yet, the line below might still error.
-- If it does, comment it out.
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local servers = { "ts_ls", "html", "cssls", "clangd", "pyright", "eslint" }

-------------------------------------------------------------------------
-- 1. Setup LspAttach Autocommand (Replaces old on_attach)
-------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Run NvChad's default attach (sets keymaps, etc.)
    if nvlsp.on_attach then
      nvlsp.on_attach(client, args.buf)
    end
    
    if nvlsp.on_init then
      nvlsp.on_init(client, args.buf)
    end
  end,
})

-------------------------------------------------------------------------
-- 2. Configure and Enable Servers (Nvim 0.11+ Native)
-------------------------------------------------------------------------
for _, server in ipairs(servers) do
  local opts = {
    capabilities = nvlsp.capabilities,
  }

  -- Configurazione specifica SOLO per ts_ls
  if server == "ts_ls" then
    opts.handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          local ignored_codes = {
            [80001] = true, -- CommonJS module...
            [6133]  = true  -- declared but never read...
          }
          
          -- Filtra creando una nuova tabella
          local new_diagnostics = {}
          for _, diagnostic in ipairs(result.diagnostics) do
            if not ignored_codes[diagnostic.code] then
              table.insert(new_diagnostics, diagnostic)
            end
          end
          result.diagnostics = new_diagnostics
        end
        
        -- Chiama la funzione nativa sicura di Neovim
        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end,
    }
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

-------------------------------------------------------------------------
-- 3. Inline Diagnostics Configuration
-------------------------------------------------------------------------
vim.diagnostic.config {
  float = { border = "rounded" },
  virtual_text = false,
}

vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
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

