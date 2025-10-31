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
        'emmet_ls',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        }
                    }
                }
            }
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
        -- print("Roslyn LSP attached")
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

vim.lsp.config("clangd", {
    cmd = {
        'clangd',
        '--background-index',
        '-j=8',
        '--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++,/opt/cuda/bin/nvcc',
        '--clang-tidy',
        '--all-scopes-completion',
        '--completion-style=detailed',
        '--header-insertion-decorators',
        '--header-insertion=iwyu',
        '--pch-storage=memory',
    },
    root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'h', 'cpp', 'hpp', 'cu', 'cuh', 'cuda' }
})

local cmp = require('cmp')
local cmp_format = lsp.cmp_format()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

