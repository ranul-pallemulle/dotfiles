-- this file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
-- or                              , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    -- config = function()
    --   vim.cmd('colorscheme rose-pine')
    -- end
  })
  use({
      'rebelot/kanagawa.nvim',
      as = 'kanagawa',
      config = function()
          vim.cmd('colorscheme kanagawa-dragon')
      end
  })
  use({
      'catppuccin/nvim',
      name = 'catppuccin',
      -- config = function()
      --     vim.cmd('colorscheme catppuccin-latte')
      -- end
  })
  use({
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons' }
  })
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          -- LSP Support
          {'williamboman/mason.nvim'}, -- Optional
          {'williamboman/mason-lspconfig.nvim'}, -- Optional
          {'neovim/nvim-lspconfig'},             -- Required
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},     -- Required
          {'hrsh7th/cmp-nvim-lsp'}, -- Required
          {'L3MON4D3/LuaSnip'},     -- Required
      }
  }
  use('lukas-reineke/indent-blankline.nvim')
  use('mhartington/formatter.nvim')
  use('lervag/vimtex')
  use({
    "L3MON4D3/LuaSnip",
  	-- follow latest release.
  	tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  	-- install jsregexp (optional!:).
  	run = "make install_jsregexp"
  })
  use({
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function() 
          require("nvim-autopairs").setup {}
      end
  })

  if packer_bootstrap then
      require('packer').sync()
  end
end)
