local status, dap = pcall(require, "dap-go")
if (not status) then return end

dap.setup()
