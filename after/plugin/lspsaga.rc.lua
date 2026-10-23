local saga = require('lspsaga')

-- Neovim 0.13 removed this private helper; lspsaga still calls it (upstream #1565)
if vim.lsp.util._get_line_byte_from_position == nil then
  ---@param bufnr integer
  ---@param position lsp.Position
  ---@param offset_encoding? string
  ---@return integer
  vim.lsp.util._get_line_byte_from_position = function(bufnr, position, offset_encoding)
    return vim.pos.lsp(bufnr, position, offset_encoding or 'utf-16')[2]
  end
end

saga.setup({
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    }
  },
  symbol_in_winbar = {
    enable = false
  },
  hover = {
    max_width = 0.8,
    max_height = 0.8,
  },
  finder = {
    default = 'ref',
    keys = {
      shuttle = '[w',
      toggle_or_open = { 'o', '<CR>' },
      vsplit = 's',
      split = 'i',
      tabe = 't',
      tabnew = 'r',
      quit = 'q',
      close = '<C-c>k',
    },
  },
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- show all references in lspsaga finder UI
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder ref<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 't', '<cmd>Lspsaga term_toggle<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
