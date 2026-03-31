vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            runtime = {
                version = "LuaJIT"
            }
        }
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("pyright", {
    settings = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'on'
            }
        }
    },
})
vim.lsp.enable("pyright")

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
vim.lsp.enable("roslyn")

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
vim.lsp.enable("clangd")

