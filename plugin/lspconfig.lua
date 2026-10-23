local protocol = require('vim.lsp.protocol')

-- Prefer oxfmt when attached; otherwise use any formatting client.
local function lsp_format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })
  local has_oxfmt = false
  for _, client in ipairs(clients) do
    if client.name == 'oxfmt' then
      has_oxfmt = true
      break
    end
  end
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if has_oxfmt then
        return client.name == 'oxfmt'
      end
      return true
    end,
  })
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      lsp_format(bufnr)
    end,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- Format on save
  enable_format_on_save(client, bufnr)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure servers using the new vim.lsp.config API (Neovim 0.11+)
vim.lsp.config('flow', {
  cmd = { 'flow', 'lsp' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx' },
  root_markers = { '.flowconfig' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('vtsls', {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true
    }
  }
})

vim.lsp.config('purescriptls', {
  filetypes = { 'purescript' },
  settings = {
    purescript = {
      addSpagoSources = true,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('sourcekit', {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('cssls', {
  cmd = { 'css-languageserver', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- ESLint / Oxlint / Oxfmt (project-local configs decide when they attach)
local eslint_default_on_attach = vim.lsp.config.eslint and vim.lsp.config.eslint.on_attach
vim.lsp.config('eslint', {
  on_attach = function(client, bufnr)
    if eslint_default_on_attach then
      eslint_default_on_attach(client, bufnr)
    end
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

local oxlint_default_on_attach = vim.lsp.config.oxlint and vim.lsp.config.oxlint.on_attach
vim.lsp.config('oxlint', {
  on_attach = function(client, bufnr)
    if oxlint_default_on_attach then
      oxlint_default_on_attach(client, bufnr)
    end
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

vim.lsp.config('oxfmt', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.enable({ 'eslint', 'oxlint', 'oxfmt' })

-- Diagnostic config (vim.lsp.with / on_publish_diagnostics config removed in Neovim 0.11+)
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    prefix = '●',
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  float = {
    source = 'always',
  },
})
