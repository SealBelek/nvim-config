local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  -- список парсеров, список доступных парсеров можно посмотреть в документации
  -- либо устаналивать все, чтобы подсветка синтаксиса работала везде корректно
  -- https://github.com/nvim-treesitter/nvim-treesitter
  ensure_installed = 'all',
  -- включить подсветку
  highlight = { enable = true }
}
