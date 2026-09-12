-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
local plugins = {
    "vague2k/vague.nvim",
    {
        'rose-pine/neovim',
        name = "rose-pine"
    },
    {
        'catppuccin/nvim',
        name = "catppuccin",
        priority = 1000
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'auto',
                }
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        branch = 'main',
        lazy = false,
        config = function()
            require('nvim-treesitter').setup()
            local parsers = {
                "lua",
                "python",
                "javascript",
                "typescript",
                "bash",
                "markdown",
                "markdown_inline",
                "regex",
                "vim",
                "vimdoc",
                "yaml",
                "xml",
            }
            vim.defer_fn(function()
                require("nvim-treesitter").install(parsers):wait(300000)
            end, 0)
            vim.api.nvim_create_autocmd('FileType', {
                pattern = parsers,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    'mbbill/undotree',
    {
        'saghen/blink.cmp',
        -- dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'enter', ['<C-k>'] = { 'show' } },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    'lukas-reineke/indent-blankline.nvim',
    'mhartington/formatter.nvim',
    {
        'lervag/vimtex',
        lazy = false,
        init = function()
            -- vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "okular"
            vim.g.vimtex_compiler_latexmk = {
                out_dir = "out"
            }
        end
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        build = "make install_jsregexp"
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                window = {
                    width = 120
                }
            }
        end
    },
    "kmonad/kmonad-vim",
    {
        "seblyng/roslyn.nvim",
        config = function()
            require("roslyn").setup {
                filewatching = "auto"
            }
        end
    },
    "mfussenegger/nvim-dap",
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        opts = {
            adapters = {
                http = {
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            env = {
                                api_key = "OPENAI_API_KEY"
                            }
                        })
                    end,
                    ollama = function()
                        return require("codecompanion.adapters").extend("ollama", {
                            schema = {
                                num_ctx = {
                                    -- default = 16384,
                                    default = 32768,
                                },
                            },
                        })
                    end,
                    ["llama.cpp"] = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            env = {
                                url = "http://localhost:8090",
                                api_key = os.getenv "LLAMA_API_KEY",
                                chat_url = "/v1/chat/completions"
                            },
                            handlers = {
                                form_messages = function(self, messages)
                                    local system_content = {}
                                    local other_messages = {}
                                    -- 1. Separate system messages from everything else
                                    for _, msg in ipairs(messages) do
                                        if msg.role == "system" then
                                            table.insert(system_content, msg.content)
                                        else
                                            table.insert(other_messages, msg)
                                        end
                                    end
                                    local final_messages = {}
                                    -- 2. If there are system messages, merge them into ONE message at the top
                                    if #system_content > 0 then
                                        table.insert(final_messages, {
                                            role = "system",
                                            content = table.concat(system_content, "\n\n"),
                                        })
                                    end
                                    -- 3. Append all the user/assistant messages
                                    for _, msg in ipairs(other_messages) do
                                        table.insert(final_messages, msg)
                                    end
                                    -- 4. Pass the cleaned messages to the standard OpenAI handler
                                    local openai = require "codecompanion.adapters.http.openai"
                                    return openai.handlers.form_messages(self, final_messages)
                                end,
                                parse_message_meta = function(self, data)
                                    local extra = data.extra
                                    if extra and extra.reasoning_content then
                                        data.output.reasoning = { content = extra.reasoning_content }
                                        if data.output.content == "" then
                                            data.output.content = nil
                                        end
                                    end
                                    return data
                                end,
                            },
                        })
                    end,
                },
            },
            interactions = {
                inline = {
                    adapter = {
                        name = "ollama",
                        model = "qwen2.5-coder:7b-instruct-q5_K_M",
                        num_ctx = 8192,
                    },
                },
                cmd = {
                    adapter = {
                        name = "ollama",
                        model = "qwen2.5-coder:7b-instruct-q5_K_M",
                        num_ctx = 8192,
                    },
                },
                chat = {
                    -- adapter = {
                    --     name = "ollama",
                    --     -- model = "mathstral:7b-v0.1-q6_K",
                    --     model = "qwen3.6:35b-a3b-q4_K_M",
                    -- },
                    adapter = {
                        name = "llama.cpp",
                        model = "Check running llama.cpp instance for model info",
                    },
                    -- adapter = {
                    --     name = "openai",
                    --     model = "gpt-5.5",
                    -- },
                    opts = {
                        system_prompt = function(ctx)
                            local prompt_file = vim.fn.getcwd() .. "/.system-prompt"
                            local ok, lines = pcall(vim.fn.readfile, prompt_file)
                            if ok and #lines > 0 then
                                return ctx.default_system_prompt .. "\n\n" .. table.concat(lines, "\n")
                            end
                            return ctx.default_system_prompt
                        end,
                    }
                },
            },
            opts = {
                log_level = "INFO",
            },
            display = {
                chat = {
                    show_settings = true,
                }
            },
            mcp = {
                servers = {
                    searxng = {
                        cmd = { "npx", "-y", "mcp-searxng" },
                        env = {
                            SEARXNG_URL = "http://localhost:8070",
                        },
                        tool_defaults = {
                            require_approval_before = true,
                        },
                    },
                },
                opts = {
                    default_servers = {
                        -- "searxng",
                    },
                },
            },
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        keymap = "gh",
                        save_chat_keymap = "sc",
                        auto_save = true,
                        auto_generate_title = false,
                        title_generation_opts = {
                            adapter = "ollama",
                            model = "qwen3:0.6b",
                        },
                        chat_filter = function(chat_data)
                            return chat_data.cwd == vim.fn.getcwd()
                        end,
                    }
                }
            }
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/codecompanion-history.nvim",
        },
    },
}

require("lazy").setup({
    spec = plugins,
    install = { colorscheme = { "default" } },
    checker = { enabled = false },
})
