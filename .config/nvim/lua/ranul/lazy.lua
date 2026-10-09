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
        "nickjvandyke/opencode.nvim",
        version = "*", -- Latest stable release
        config = function()
            vim.g.opencode_opts = {
            }
            -- Recommended/example keymaps
            vim.keymap.set({ "n", "x" }, "<C-a>",   function() require("opencode").ask("@this: ") end,                    { desc = "Ask OpenCode…" })
            vim.keymap.set({ "n", "x" }, "<C-x>",   function() require("opencode").select() end,                          { desc = "Select OpenCode…" })
            vim.keymap.set({ "n", "x" }, "go",      function() return require("opencode").operator("@this ") end,         { desc = "Append range to OpenCode", expr = true })
            vim.keymap.set({ "n" },      "goo",     function() return require("opencode").operator("@this ") .. "_" end,  { desc = "Append line to OpenCode", expr = true })
            vim.keymap.set({ "n" },      "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
            vim.keymap.set({ "n" },      "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
        end,
    }
}

require("lazy").setup({
    spec = plugins,
    install = { colorscheme = { "default" } },
    checker = { enabled = false },
})
