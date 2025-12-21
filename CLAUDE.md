# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

**NOE.ED** is a Neovim configuration based on LazyVim, a modern Neovim distribution. The configuration is organized using the lazy.nvim plugin manager with a modular structure.

## Architecture

### Plugin Loading System

The configuration uses a three-level plugin loading architecture (lua/config/lazy.lua:17-24):

1. **Core LazyVim plugins** - Base LazyVim distribution (`lazyvim.plugins`)
2. **Custom plugins** - Main plugin overrides and additions (`plugins/`)
3. **Language-specific plugins** - Language tooling configs (`plugins/languages/`)
4. **Theme plugins** - Theme and UI customizations (`plugins/themes/`)

### Directory Structure

```
lua/
├── config/           # Core configuration
│   ├── lazy.lua     # Plugin manager bootstrap and setup
│   ├── options.lua  # Vim options (wrap, undofile, etc.)
│   ├── keymaps.lua  # Custom keybindings
│   └── autocmds.lua # Autocommands
└── plugins/          # Plugin configurations
    ├── languages/   # Language-specific LSP/tooling configs
    ├── themes/      # Theme and statusline configs
    └── *.lua        # Individual plugin configs
```

### Key Configuration Files

- **init.lua** - Entry point, loads `config.lazy`
- **lazyvim.json** - LazyVim extras configuration (enabled language packs, utilities)
- **lazy-lock.json** - Plugin version lockfile

## Enabled LazyVim Extras

This configuration includes the following LazyVim extras (from lazyvim.json):

**AI/Coding:**

- claudecode (Claude Code integration)
- supermaven (AI completion)
- mini-surround (surround text objects)
- dap.core (debugging)

**Languages:**

- Go, Python, Rust, TypeScript, PHP
- Astro, Svelte, Vue
- Docker, Helm, YAML, TOML, JSON, Markdown

**Utilities:**

- GitHub CLI integration
- REST client
- Mini-hipatterns
- Snacks explorer & picker
- Biome formatting

## Plugin Configuration Patterns

### Plugin Override Pattern

Plugins are configured by returning a table with the plugin spec:

```lua
return {
  "plugin/name",
  opts = {
    -- options here
  }
}
```

### Language-Specific Configurations

Language configs in `lua/plugins/languages/` extend LSP server configurations:

```lua
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers.servername = {
      settings = { ... }
    }
    return opts
  end
}
```

Example: lua/plugins/languages/go.lua configures gopls with gofumpt, auto-imports, and staticcheck.

## Key Custom Keybindings

The configuration uses `<leader>` (Space) as the primary prefix. Notable custom bindings (lua/config/keymaps.lua):

**General:**

- `jj` / `jk` - Exit INSERT mode
- `U` - Redo (shift+u)
- `<C-a>` - Select all
- `gh` / `gl` - Jump to beginning/end of line
- `<Alt-j/k>` or `<Alt-up/down>` - Move lines up/down
- `<Enter>` - Code folding toggle

**AI/Claude Code (<leader>a):**

- `<leader>ac` - Toggle Claude
- `<leader>af` - Focus Claude
- `<leader>ar` - Resume Claude
- `<leader>ab` - Add current buffer to Claude context
- `<leader>aa` - Accept diff
- `<leader>ad` - Deny diff

**File/Window Management:**

- `<leader>fs` - Save file
- `<C-hjkl>` - Navigate splits
- `<C-`>` - Toggle terminal

**Search/Navigation:**

- `<leader>jj` - Flash jump (leap to character)
- `<C-n>` - Multi-word editing (use `.` to repeat)

**Git:**

- `<leader>gg` - LazyGit (borderless)

## Custom Options

Key vim options set in lua/config/options.lua:

- Word wrap enabled (`wrap = true`)
- No swap files (`swapfile = false`)
- No backup files (`backup = false`)
- Undo directory: `~/.local/state/nvim/undo`
- Platform: macOS arm64 (for Codeium)

## Theme Configuration

### Colorscheme Management

**Single source of truth:** All colorscheme plugins and the active colorscheme setting are in `lua/plugins/ui/colorscheme.lua`

**To change colorscheme:** Edit the `colorscheme` value in colorscheme.lua:
```lua
{
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "eldritch",  -- Change this value
  },
}
```

**Available colorschemes:**
- Eldritch: `"eldritch"`
- Aura: `"aura-dark"`, `"aura-dark-soft-text"`, `"aura-soft-dark"`, `"aura-soft-dark-soft-text"`
- Rose Pine: `"rose-pine"`, `"rose-pine-moon"`, `"rose-pine-dawn"`
- Tokyo Night: `"tokyonight"`, `"tokyonight-storm"`, `"tokyonight-moon"`, `"tokyonight-day"`

**Theme switcher:** A system-wide theme switcher script is located at `~/.dotfiles/config/.config/theme-switcher/`. It provides an fzf-based interface to switch themes across multiple applications (ghostty, wezterm, neovim, bat, lazygit, oh-my-posh, kitty, btop).

**Usage:**
- Run `theme` in fish shell - opens interactive picker and auto-refreshes oh-my-posh prompt
- Run `theme <theme-name>` - switches to specific theme
- Direct script: `~/.config/theme-switcher/theme-switcher.sh`

**Manual reloads:**
- **Ghostty**: Press `Cmd+Ctrl+Alt+,` to reload config
- **Prompt**: Auto-refreshes when using fish `theme` wrapper

**Apps that auto-update:** bat, lazygit, oh-my-posh (with fish `theme` wrapper)
**Apps requiring restart:** Neovim, WezTerm, Kitty, btop, Ghostty (or use keybind)

### NEO.ED Lualine Theme

The statusline uses a custom colorscheme-adaptive theme that automatically matches your active colorscheme. See `lua/plugins/ui/lualine/README.md` for full documentation.

**How it works:**
1. On startup: Reads colorscheme from `LazyVim.opts("LazyVim").colorscheme`
2. On colorscheme change: Autocmd detects change and refreshes lualine
3. Manual refresh: `:LualineRefresh`

**Customization with overrides:** Each palette file supports a `get_overrides(colors)` function that lets you reference palette colors:
```lua
-- In lua/plugins/ui/lualine/aura.lua
get_overrides = function(colors)
  return {
    normal = { a = { fg = colors.red, bg = colors.darkGray } },
    insert = { a = { fg = colors.bg, bg = colors.magenta } },
  }
end
```

Global overrides for all colorschemes can be set in `neoed.lua`. See the README for details.

## Working with This Configuration

### Adding New Plugins

1. Create a new file in `lua/plugins/` named after the plugin
2. Return a plugin spec table
3. Plugin will auto-load on next Neovim start

### Adding Language Support

1. Add the language extra in Neovim: `:LazyExtras`
2. Optionally create language-specific config in `lua/plugins/languages/[lang].lua`
3. Update lazyvim.json (automatically done by LazyExtras)

### Modifying Keybindings

Edit `lua/config/keymaps.lua`. The file uses:

- `vim.keymap.set()` for setting keymaps
- `require("which-key").add()` for groupings

### Disabling Plugins

Add plugin disable specs to `lua/plugins/disabled.lua`:

```lua
return {
  { "plugin/name", enabled = false }
}
```

## Development Workflow

This is a Neovim configuration, not a traditional software project. There are no build, test, or lint commands. Configuration changes take effect by:

1. Restarting Neovim
2. Using `:source %` to reload current file
3. Using `:Lazy sync` to update plugins

## Notes

- Plugin updates are automatically checked on startup (lua/config/lazy.lua:36-39)
- Some default rtp plugins are disabled for performance (gzip, tar, zip, tutor)
- The configuration emphasizes modal editing with extensive custom keybindings
- Claude Code integration is a primary feature with dedicated keymap group
