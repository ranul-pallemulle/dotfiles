local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {}) -- pf because "project files"
vim.keymap.set('n', '<C-p>', builtin.git_files, {}) -- git file search
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {}) -- ps because "project search" NOTE: requires ripgrep
-- vim.keymap.set('n', '<leader>ps', function() -- ps because "project search"
--   builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
