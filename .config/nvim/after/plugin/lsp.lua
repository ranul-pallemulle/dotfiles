local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require('mason-lspconfig').setup({
    ensure_installed = {
        'ts_ls',
        'eslint',
        'rust_analyzer',
        'lua_ls',
        'pyright',
        'clangd',
        'emmet_ls',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        end,
        clangd = function()
            require('lspconfig').clangd.setup({
                on_attach = lsp.on_attach,
                cmd = {'clangd', '--query-driver=/usr/bin/gcc,/use/bin/g++'},
            })
        end,
        pyright = function()
            require('lspconfig').pyright.setup({
                on_attach = lsp.on_attach,
                settings = {
                    pyright = {
                        autoImportCompletion = true,
                    },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = 'off'
                        }
                    }
                }
            })
        end,
    },
})

vim.lsp.config("roslyn", {
    on_attach = function()
        print("Roslyn LSP attached")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    }
})

local cmp = require('cmp')
local cmp_format = lsp.cmp_format()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

