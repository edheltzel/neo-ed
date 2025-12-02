# Plugin Configuration Patterns

## Table of Contents

1. [Basic Plugin Spec](#basic-plugin-spec)
2. [Opts Patterns](#opts-patterns)
3. [Dependencies](#dependencies)
4. [Lazy Loading](#lazy-loading)
5. [Overriding LazyVim Defaults](#overriding-lazyvim-defaults)
6. [Disabling Plugins](#disabling-plugins)
7. [NOE.ED Examples](#noeed-examples)

## Basic Plugin Spec

```lua
return {
  "author/plugin-name",
  opts = {
    option = "value",
  },
}
```

## Opts Patterns

### Static Opts

```lua
return {
  "plugin/name",
  opts = {
    setting = true,
    nested = { key = "value" },
  },
}
```

### Dynamic Opts (Function)

```lua
return {
  "plugin/name",
  opts = function(_, opts)
    -- Modify opts in place or return new table
    opts.setting = true
    return opts
  end,
}
```

### Extend Existing Opts

```lua
return {
  "plugin/name",
  opts = function(_, opts)
    -- Add to existing table
    opts.servers = opts.servers or {}
    opts.servers.newserver = { settings = {} }
    return opts
  end,
}
```

## Dependencies

### Basic Dependencies

```lua
return {
  "plugin/name",
  dependencies = {
    "other/plugin",
    "another/plugin",
  },
}
```

### Dependencies with Config

```lua
return {
  "plugin/name",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "tool-name")
      end,
    },
  },
}
```

### Optional Dependencies

```lua
return {
  "plugin/name",
  optional = true,  -- Won't error if not installed
  dependencies = { ... },
}
```

## Lazy Loading

### Event-Based

```lua
return {
  "plugin/name",
  event = "VeryLazy",  -- After UI loads (most common)
}

return {
  "plugin/name",
  event = { "BufReadPre", "BufNewFile" },  -- On buffer open
}

return {
  "plugin/name",
  event = "InsertEnter",  -- On insert mode
}
```

### Keymap-Based

```lua
return {
  "plugin/name",
  keys = {
    { "<leader>xx", "<cmd>PluginCommand<cr>", desc = "Run Plugin" },
    { "<leader>xy", function() require("plugin").action() end, desc = "Action" },
  },
}
```

### Filetype-Based

```lua
return {
  "plugin/name",
  ft = { "lua", "python", "go" },
}
```

### Command-Based

```lua
return {
  "plugin/name",
  cmd = { "PluginCommand", "PluginOther" },
}
```

## Overriding LazyVim Defaults

### Change LazyVim Options

```lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "eldritch",
    },
  },
}
```

### Override Plugin Config

```lua
-- In lua/plugins/override.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "python", "go" },
      highlight = { enable = true },
    },
  },
}
```

### Add to Mason Ensure Installed

```lua
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shfmt",
        "prettier",
      })
    end,
  },
}
```

## Disabling Plugins

### In disabled.lua

```lua
return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
}
```

### Inline Disable

```lua
return {
  { "plugin/name", enabled = false },
}
```

## NOE.ED Examples

### Claude Code Integration (ai/claudecode.lua)

```lua
return {
  "anthropics/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    window = {
      position = "float",
      float_opts = { border = "rounded" },
    },
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCodeToggle<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
  },
}
```

### Git Integration (editor/git.lua)

```lua
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
      },
    },
  },
}
```

### Conform Formatter (formatting/conform.lua)

```lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      yaml = { "prettier" },  -- Override default
    },
  },
}
```

### Snacks UI (utils/snacks.lua)

```lua
return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
```

### Multi-Plugin Return

```lua
return {
  -- First plugin
  {
    "plugin/one",
    opts = {},
  },
  -- Second plugin
  {
    "plugin/two",
    dependencies = { "plugin/one" },
  },
}
```
