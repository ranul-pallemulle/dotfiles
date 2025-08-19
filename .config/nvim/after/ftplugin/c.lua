vim.bo.commentstring = '/* %s */'
vim.opt_local.formatoptions:remove({ 'r', 'o' }) -- prevent newline continuing a comment
