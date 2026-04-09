local status, lazy = pcall(require, "lazy")
if (not status) then
  print("Lazy is not installed")
  return
end

lazy.setup({
  --{
  --  'svrana/neosolarized.nvim', -- colorschema
  --  dependencies = { 'tjdevries/colorbuddy.nvim' }
  -- },
  {
  "nemanjamalesija/ts-expand-hover.nvim",
  ft = { "typescript", "typescriptreact" },
  opts = {
    keymaps = { hover = "K" }
  }
  },
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

  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      input = {}, -- Enhances `ask()`
      picker = { -- Enhances `select()`
        enabled = true,
      },
    },
  },
  {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-/>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
   end,
  },
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false,
    opts = {
      acp_providers = {
        ["opencode"] = {
          command = "opencode",
          args = { "acp" }
        }
      },
      instructions_file = "avante.md",
      suggestion = {
        debounce = 600,
        throttle = 600,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

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
