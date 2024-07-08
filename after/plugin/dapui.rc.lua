local status, dap = pcall(require, "dapui")
if (not status) then return end

dap.setup()
