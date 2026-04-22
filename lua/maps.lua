local keymap = vim.keymap

-- Initialize DAP properly
local dap_status, dap = pcall(require, "dap")
if dap_status then
  -- Ensure signs are defined
  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DiagnosticWarning", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
end

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Debug
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<Leader>ds', function() require('dap').terminate() end) -- Stop debugging
vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end) -- Toggle DAP UI
vim.keymap.set('n', '<Leader>dh', function() require('dap.ui.widgets').hover() end) -- Hover variables
vim.keymap.set('n', '<Leader>dp', function() require('dap.ui.widgets').preview() end) -- Preview variables
vim.keymap.set('n', '<Leader>df', function() require('dap.ui.widgets').focus_stack() end) -- Focus stack

-- Direct DAP commands for troubleshooting
vim.keymap.set('n', '<Leader>dtb', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '\\b', function() require('dap').toggle_breakpoint() end)

-- Format file
vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format() end)

-- Rename variable
vim.keymap.set('n', '<Leader>rn', function() vim.lsp.buf.rename() end)

vim.keymap.set('n', '<leader>ps', function()
	require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end)
