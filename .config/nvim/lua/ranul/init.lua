require("ranul.lazy")
require("ranul.set")
require("ranul.remap")

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { '.git'}
})

vim.lsp.enable("clangd")

