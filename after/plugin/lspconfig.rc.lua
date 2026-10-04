vim.lsp.config('svelte', {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      group = vim.api.nvim_create_augroup("svelte_ts_sync", { clear = true }),
      callback = function(ctx)
        client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end,
    })
  end,
})

vim.lsp.enable('svelte')
