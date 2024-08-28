-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ayu_dark",
  theme_toggle = { "ayu_dark", "one_light" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    Normal = { bg = { "black", 2 } },
    NvimTreeNormal = { bg = { "black", 1 } },
    NvimTreeNormalNC = { bg = { "black", 1 } },
    NvimTreeWinSeparator = { bg = { "black", 1 }, fg = { "black", 1 } },
    NvimTreeCursorLine = { bg = { "black", 7 } },
    NvimTreeOpenedFolderName = { fg = "#36A3D9", bold = true },

    TbBufOn = {
      fg = "#36A3D9",
      bg = "#2B2E34",
      bold = true,
    },

    TbBufOnClose = {
      bg = "#2B2E34",
    },
  },

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    overriden_modules = function()
      return {
        -- add parent dir to filename
        fileInfo = function()
          local icon = " 󰈚 "
          local filename = (vim.fn.expand "%" == "" and "Empty ")
            or vim.fn.expand "%:p:h:t" .. "/" .. vim.fn.expand "%:t"
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

return M
