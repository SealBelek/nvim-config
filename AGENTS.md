# AGENTS.md – Neovim Config Guide

## What This Is

A personal Neovim configuration (dotfiles) repository, published at [github.com/SealBelek/nvim-config](https://github.com/SealBelek/nvim-config). Uses **lazy.nvim** as the plugin manager. Everything is configured in Lua.

## Entry Point

- `init.lua` – loads base config modules in this order:
  1. `init-lazy.lua` – bootstraps lazy.nvim plugin manager
  2. `base.lua` – editor settings (tabs, indent, encoding, etc.)
  3. `highlights.lua` – appearance (colors, cursor, transparency)
  4. `maps.lua` – key mappings (normal + debug + lsp)
  5. `plugins.lua` – plugin specs and configuration
  6. OS-specific overrides: `macos.lua`, `windows.lua`, `wsl.lua` (checked via `vim.fn.has`)

## Plugin Manager & Key Plugins

- **lazy.nvim** manages all plugins (specs in `lua/plugins.lua`)
- **LSP stack**: nvim-lspconfig + mason + mason-lspconfig for automatic language server setup
- **Completion**: nvim-cmp + snippets (LuaSnip)
- **UI**: lspsaga (LSP UI), lualine (statusline), nvim-bufferline (tabs)
- **Navigation**: telescope + telescope-file-browser, nvim-tree (file explorer)
- **Git**: gitsigns + git.nvim (git blame, browse)
- **AI**: avante.nvim (configured to use OpenCode via `acp_providers`) + opencode.nvim plugin
- **Debug**: nvim-dap + nvim-dap-go + nvim-dap-ui + telescope-dap
- **Syntax**: nvim-treesitter (with `:TSUpdate` build command)
- **Theme**: tokyonight.nvim

## Making Changes

### Adding or Removing Plugins
- Edit `lua/plugins.lua`
- Lazy handles installation/cleanup automatically on restart
- Check `lazy-lock.json` after changes (tracks pinned versions)

### Modifying Key Bindings
- Edit `lua/maps.lua` for general mappings
- Debug keymaps hardcoded in `maps.lua`: F5 (continue), F10 (step over), F11 (step into), F12 (step out), `<Leader>b` (toggle breakpoint), etc.
- OpenCode keymaps in `plugins.lua` (lines 66–74): `<C-a>` (ask), `<C-x>` (select action), `<C-/>` (toggle)

### Adjusting Editor Settings
- Edit `lua/base.lua` for vim options (tabs, indent, line wrap, encoding, etc.)
- Edit `lua/highlights.lua` for appearance (cursor line, colors, yank highlight duration)

### OS-Specific Config
- Shell configured to `/usr/bin/zsh` in `base.lua:6`
- Platform checks in `init.lua` (lines 7–19) load `macos.lua`, `windows.lua`, or `wsl.lua` if applicable
- These files are currently empty stubs; add platform-specific options there if needed

## Development Quirks

- **lazy.nvim bootstrap** (init-lazy.lua): clones lazy.nvim on first run if not present
- **LSP autocomplete** requires mason to download servers on first use (run `:Mason`)
- **Treesitter parsers** must be updated with `:TSUpdate` when lazy.nvim updates them
- **Avante.nvim build step** runs `make` on Unix or PowerShell Build.ps1 on Windows (line 83–84); requires pre-installed build tools
- **Git integration** uses `/usr/bin/zsh` shell; some git commands may behave differently on WSL or Windows

## Testing & Verification

No test suite exists. Verify config by:
1. Start nvim and check startup messages (`:messages`)
2. Check plugin load status (`:Lazy` dashboard)
3. Verify LSP is running (`:LspInfo`) and servers are downloaded (`:Mason`)
4. Test key bindings manually

## Commit & Push Workflow

Repository is clean and tracked with git. Standard workflow:
- Make changes to `.lua` files
- Commit with clear messages (repo uses simple English, no emojis)
- Push to `origin/main` (public repo, so be careful with secrets)
- `.githuman/` directory is git-ignored (local GitHuman metadata)

## Common Gotchas

1. **Plugin specs use lazy.nvim syntax**, not packer (migrated in commit f8f7c16). Dependencies are declared inline.
2. **Order matters in init.lua** – lazy must bootstrap before plugins are loaded
3. **Avante instructions file** is set to `avante.md` (line 95); if you create an avante-specific instruction file, update this reference
4. **Linting/formatting** is not configured in this repo; relies on LSP servers installed by mason to provide those features
5. **Debug configuration** is minimal; nvim-dap is installed but go-specific setup is in nvim-dap-go; other languages need explicit dap config
