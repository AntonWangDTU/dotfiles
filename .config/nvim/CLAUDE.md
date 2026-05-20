# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a [LazyVim](https://lazyvim.github.io)-based Neovim configuration. It uses **lazy.nvim** as the plugin manager and **LazyVim** as the base framework, extending it with custom plugins and settings.

## Architecture

### Entry Point & Load Order

`init.lua` bootstraps the config:
1. `require("config.lazy")` — initializes lazy.nvim and loads all plugins
2. `require("config.keymaps")` — applies custom keymaps after plugins load
3. LuaSnip snippets loaded from `snippets/`
4. Global vimtex and autocmd settings

### Directory Layout

- `lua/config/` — core settings: `lazy.lua` (plugin manager init), `options.lua`, `keymaps.lua`, `autocmds.lua`, `cmp.lua`
- `lua/plugins/` — plugin specs; each file returns a lazy.nvim plugin spec table
- `snippets/` — LuaSnip snippets in Lua format (`python.lua`, `lua.lua`, `tex.lua`, `tex/math.lua`)
- `lazyvim.json` — LazyVim extras enabled for this config
- `.neoconf.json` — per-project LSP settings (neodev/lua_ls)
- `.theme` — persisted active colorscheme name (read/written at runtime)
- `stylua.toml` — Lua formatter config (used by `stylua`)

### LazyVim Extras Enabled

Configured in `lazyvim.json`:
- `lazyvim.plugins.extras.ai.copilot`
- `lazyvim.plugins.extras.coding.luasnip`
- `lazyvim.plugins.extras.lang.python`
- `lazyvim.plugins.extras.lang.tex`
- `lazyvim.plugins.extras.ui.alpha`
- `lazyvim.plugins.extras.util.project`

### Key Custom Behaviors

**Theme persistence & sync** (`lua/config/keymaps.lua`, `lua/config/autocmds.lua`):
- `<leader>tt` toggles between `tokyonight-night` (dark) and `github_light` (light)
- Active theme is written to `.theme`; all open Neovim instances sync via `FocusGained` autocommand

**LaTeX** (`init.lua`, `lua/plugins/vimtex.lua`):
- Auto-compiles `.tex` files on save via `latexmk -pdf`; output goes to `latex_out/`
- Opening a `.pdf` launches `sioyek` and closes the buffer
- VimTeX viewer: `sioyek`

**Completion** (`lua/config/cmp.lua`):
- LuaSnip is the snippet source (keyword_length=2, max 3 items)
- Toggle autocompletion: `<leader>ua`

**LSP** (`lua/plugins/lsp.lua`):
- Pyright configured with stub path `/home/jsr-p/typings/`, `openFilesOnly` mode, no auto-import

## Adding/Modifying Plugins

Create or edit a file in `lua/plugins/`. Each file returns a lazy.nvim spec, for example:

```lua
return {
  "author/plugin-name",
  opts = { ... },
}
```

Run `:Lazy` inside Neovim to install/update plugins. The lock file is `lazy-lock.json`.

## Formatting

Lua files are formatted with `stylua`. Config is in `stylua.toml`. Run:

```sh
stylua lua/ init.lua
```
