local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim', -- colorschema
    requires = { 'tjdevries/colorbuddy.nvim' }
  }

  use {
    'nvim-tree/nvim-tree.lua',       -- file explorer
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  use 'nvim-lualine/lualine.nvim'       -- Statusline
  use 'nvim-lua/plenary.nvim'           -- Common utilities
  use 'onsails/lspkind-nvim'            -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'              -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'            -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'                -- Completion
  use 'neovim/nvim-lspconfig'           -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'         -- Package manager for lsp
  use 'williamboman/mason-lspconfig.nvim'

  use 'glepnir/lspsaga.nvim'         -- LSP UIs
  use 'L3MON4D3/LuaSnip'
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use 'akinsho/nvim-bufferline.lua'
  -- use 'github/copilot.vim'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  use 'purescript-contrib/purescript-vim'

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  use {
    "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = {
    "markdown" },
  }
end)
