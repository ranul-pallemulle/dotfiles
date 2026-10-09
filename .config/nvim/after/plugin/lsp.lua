vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            codeLens = { enable = true },
            hint = { enable = true, semicolon = 'Disable' },
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

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact"}
})
vim.lsp.enable("ts_ls")

vim.lsp.config("pyright", { -- NOT USED - using basedpyright (below) instead
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
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
    },
})
vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'off',
            },
            disableTaggedHints = true,
        }
    }
})
--vim.lsp.enable("pyright")
vim.lsp.enable("basedpyright")

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
        ["csharp|background_analysis"] = {
            background_analysis = {
                dotnet_analyzer_diagnostics_scope = "fullSolution",
            }
        }
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
    -- filetypes = { 'c', 'h', 'cpp', 'hpp', 'cu', 'cuh', 'cuda' }
    filetypes = { 'c', 'cpp', 'cuda' }
})
vim.lsp.enable("clangd")

vim.lsp.config("texlab", {
    filetypes = { 'tex', 'bib' }
})
vim.lsp.enable("texlab")

-- avalonia 
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	pattern = { "*.axaml" },
	callback = function(event)
		vim.lsp.start {
			name = "avalonia",
			cmd = { "avalonia-ls" },
			root_dir = vim.fn.getcwd(),
		}
	end
})
vim.filetype.add({
    extension = {
        axaml = "xml",
    },
})

-- keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
