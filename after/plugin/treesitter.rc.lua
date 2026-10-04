-- nvim-treesitter (ветка main) — требуется для Neovim 0.12+
-- Старый модуль `nvim-treesitter.configs` в ветке main больше не существует,
-- а `ensure_installed`/`highlight` из него заменены на API ниже.
local status, ts = pcall(require, "nvim-treesitter")
if not status then return end

-- Установить парсеры (no-op, если уже установлены; выполняется асинхронно).
-- Список доступных парсеров: https://github.com/nvim-treesitter/nvim-treesitter
ts.install { "lua", "go", "typescript", "javascript", "markdown", "markdown_inline", "svelte" }

-- Включить подсветку синтаксиса для всех файлтипов, у которых есть парсер.
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
