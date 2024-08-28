require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<C-a>", "<esc>ggVG", { desc = "Select all" })
map("n", "<Esc>", "<cmd>noh <CR>", { desc = "Clear highlights", silent = true })
map(
  "n",
  "<leader>q",
  "<cmd>Trouble diagnostics toggle<CR>",
  { desc = "Toggle Trouble quickfix list", noremap = true, silent = true }
)
map(
  "n",
  "<F5>",
  ":%s/\\s\\+$//ge<CR> | :nohl<CR> | :retab<CR> | gg^",
  { desc = "Auto trail extra spaces", noremap = true, silent = true }
)

map(
  "i",
  "<C-e>",
  "<ESC>:call emmet#expandAbbr(3,'')<CR>i",
  { desc = "Expand Emmet abbreviation", noremap = true, silent = true }
)
