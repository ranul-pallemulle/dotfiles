local function format_prettier()
    return {
        exe = "npx",
        args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

require'formatter'.setup {
    logging = true,
    filetype = {
        typescript = { format_prettier },
        javascript = { format_prettier },
    }
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

