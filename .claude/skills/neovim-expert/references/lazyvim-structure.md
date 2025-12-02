# LazyVim Structure & Plugin Loading

## Table of Contents

1. [Entry Point](#entry-point)
2. [Plugin Loading Order](#plugin-loading-order)
3. [LazyVim Extras](#lazyvim-extras)
4. [Config Directory](#config-directory)
5. [Plugins Directory](#plugins-directory)

## Entry Point

`init.lua` bootstraps lazy.nvim:

```lua
require("config.lazy")
```

## Plugin Loading Order

Defined in `lua/config/lazy.lua:20-33`:

```lua
spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "plugins.ai" },
  { import = "plugins.coding" },
  { import = "plugins.dap" },
  { import = "plugins.editor" },
  { import = "plugins.formatting" },
  { import = "plugins.languages" },
  { import = "plugins.linting" },
  { import = "plugins.ui" },
  { import = "plugins.utils" },
}
```

**Load order matters** - later specs can override earlier ones.

## LazyVim Extras

Managed via `lazyvim.json`. Enable/disable with `:LazyExtras`.

### Currently Enabled (32 extras)

**AI/Coding:**
- `lazyvim.plugins.extras.ai.claudecode`
- `lazyvim.plugins.extras.ai.codeium`
- `lazyvim.plugins.extras.coding.mini-surround`
- `lazyvim.plugins.extras.dap.core`

**Editor:**
- `lazyvim.plugins.extras.editor.harpoon2`
- `lazyvim.plugins.extras.editor.mini-files`
- `lazyvim.plugins.extras.editor.snacks_explorer`
- `lazyvim.plugins.extras.editor.snacks_picker`

**Languages:**
- go, python, rust, typescript, php
- angular, astro, docker, elixir, helm
- json, markdown, svelte, tailwind, terraform
- toml, twig, vue, yaml

**Utilities:**
- `lazyvim.plugins.extras.util.dot`
- `lazyvim.plugins.extras.util.mini-hipatterns`
- `lazyvim.plugins.extras.formatting.biome`

### Adding an Extra

1. Run `:LazyExtras`
2. Navigate to desired extra
3. Press `x` to toggle
4. Restart Neovim

Or manually edit `lazyvim.json`:

```json
{
  "extras": [
    "lazyvim.plugins.extras.lang.python"
  ]
}
```

## Config Directory

`lua/config/` contains core settings loaded before plugins:

| File | Purpose | When Loaded |
|------|---------|-------------|
| `lazy.lua` | Plugin manager setup | First (from init.lua) |
| `options.lua` | `vim.opt` settings | Before plugins |
| `keymaps.lua` | Custom keybindings | After plugins |
| `autocmds.lua` | Autocommands | After plugins |
| `filetypes.lua` | Filetype associations | After plugins |

### options.lua Key Settings

```lua
opt.wrap = true           -- Word wrap
opt.swapfile = false      -- No swap files
opt.backup = false        -- No backups
opt.undofile = true       -- Persistent undo
opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
opt.cursorline = true     -- Highlight cursor line
opt.cursorcolumn = true   -- Highlight cursor column
opt.scrolloff = 5         -- Lines above/below cursor
o.timeoutlen = 250        -- Keymap timeout (ms)
```

## Plugins Directory

`lua/plugins/` organized by category:

```
plugins/
├── disabled.lua      # { "plugin", enabled = false }
├── ai/
│   ├── claudecode.lua
│   ├── opencode.lua
│   └── windsurf.lua
├── coding/
│   ├── surround.lua
│   └── emmet.lua
├── editor/
│   ├── git.lua
│   └── multicursor.lua
├── formatting/
│   ├── conform.lua
│   └── prettier.lua
├── languages/        # 11 language configs
│   ├── go.lua
│   ├── python.lua
│   ├── typescript.lua
│   └── ...
├── linting/
│   └── biome.lua
├── ui/
│   ├── colorscheme.lua
│   ├── eldritch.lua
│   ├── lualine.lua
│   └── lualine/
│       ├── neoed.lua
│       ├── eldritch.lua
│       └── rose-pine.lua
├── utils/
│   └── snacks.lua
└── dap/
```

### File Naming Convention

- One plugin per file: `pluginname.lua`
- Match plugin repo name when possible
- Use hyphens: `treesitter-context.lua`
- Subdirs for complex configs: `lualine/neoed.lua`
