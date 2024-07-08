local status, lazy = pcall(require, "lazy")
if (not status) then
  print("Lazy is not installed")
  return
end

lazy.setup({
  'wbthomason/packer.nvim',
  --{
  --  'svrana/neosolarized.nvim', -- colorschema
  --  dependencies = { 'tjdevries/colorbuddy.nvim' }
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'nvim-tree/nvim-tree.lua',       -- file explorer
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  'nvim-lualine/lualine.nvim', -- Statusline
  'nvim-lua/plenary.nvim',     -- Common utilities
  'onsails/lspkind-nvim',      -- vscode-like pictograms
  -- deps for autocomplet
  'hrsh7th/cmp-buffer',        -- nvim-cmp source for buffer words
  'hrsh7th/cmp-nvim-lsp',      -- nvim-cmp source for neovim's built-in LSP
  'hrsh7th/cmp-path',
  -- autocomplet
  'hrsh7th/nvim-cmp', -- Completion

  'Exafunction/codeium.vim',
  -- configs for lsp servers
  'neovim/nvim-lspconfig', -- LSP

  --  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  'williamboman/mason.nvim', -- Package manager for lsp
  'williamboman/mason-lspconfig.nvim',
  -- LSP UIs
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
      'nvim-lspconfig',
    },
  },
  "ray-x/lsp_signature.nvim",
  -- парсер для всех языков программирования, цветной код как в твоем
  -- любимом IDE
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'kyazdani42/nvim-web-devicons', -- File icons
  'L3MON4D3/LuaSnip',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',

  'windwp/nvim-autopairs',
  'norcalli/nvim-colorizer.lua',
  'folke/zen-mode.nvim',
  -- buffer/tabs at horizontal menu
  'akinsho/nvim-bufferline.lua',
  -- use 'github/copilot.vim'

  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim', -- For git blame & browse

  'purescript-contrib/purescript-vim',
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- Debug
  'mfussenegger/nvim-dap',
  'leoluz/nvim-dap-go',
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim'
})
