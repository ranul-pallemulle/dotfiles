vim.g.mapleader = " " -- map space to leader
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- n means normal mode

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode, use J and K to move the selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep cursor in the middle of the screen when using C-d, C-u
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv") -- when searching, keep cursor in the middle of the screen
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP") -- use <leader>p to paste without losing the item in the paste buffer

vim.keymap.set("n", "<leader>y", "\"+y") -- copy stuff to the system clipboard with <leader>y
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
