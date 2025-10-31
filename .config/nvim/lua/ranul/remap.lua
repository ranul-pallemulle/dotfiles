vim.g.mapleader = " " -- map space to leader
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- n means normal mode

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode, use J and K to move the selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep cursor in the middle of the screen when using C-d, C-u
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv") -- when searching, keep cursor in the middle of the screen
vim.keymap.set("n", "N", "Nzzzv")

-- integrate with system clipboard
vim.keymap.set("n", "<leader>y", "\"*y")
vim.keymap.set("x", "<leader>y", "\"*y")
vim.keymap.set("n", "<leader>p", "\"*p")
vim.keymap.set("x", "<leader>p", "\"*p")
vim.keymap.set("n", "<leader>Y", "\"+y")
vim.keymap.set("x", "<leader>Y", "\"+y")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("x", "<leader>P", "\"+P")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- remap switch between splits
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")
