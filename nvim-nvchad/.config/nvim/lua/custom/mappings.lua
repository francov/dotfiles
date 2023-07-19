---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>mr"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain!" },
    ["<leader>lg"] = { "<cmd>LazyGit<CR>", "Open LazyGit" },
    ["<C-a>"] = { "<esc>ggVG", "Select all" },
    ["<F5>"] = {
      ":%s/\\s\\+$//ge<CR> | :nohl<CR> | :retab<CR> | gg^",
      "Auto trail extra spaces",
      opts = { noremap = true, silent = true },
    },
    ["<C-p>"] = { '"0P', "Magic paste previous yanked things after a delete!" },
    ["<Esc>"] = { ":noh <CR>", "Clear highlights", opts = { silent = true } },
    ["<leader>q"] = {
      ":TroubleToggle<CR>",
      "Toggle Trouble quickfix list",
      opts = { noremap = true, silent = true },
    },
  },
  i = {
    ["<C-e>"] = {
      "<ESC>:call emmet#expandAbbr(3,'')<CR>i",
      "Expand Emmet abbreviation",
      opts = { noremap = true, silent = true },
    },
  },
}

-- more keybinds!

return M
