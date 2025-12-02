# Keymaps Reference

## Table of Contents

1. [Keymap API](#keymap-api)
2. [Which-Key Integration](#which-key-integration)
3. [NOE.ED Custom Keymaps](#noeed-custom-keymaps)
4. [LazyVim Default Keymaps](#lazyvim-default-keymaps)
5. [Adding New Keymaps](#adding-new-keymaps)

## Keymap API

### Basic Keymap

```lua
vim.keymap.set("n", "key", "action", { desc = "Description" })
```

### With Options

```lua
local set = vim.keymap.set

set("n", "<leader>xx", "<cmd>Command<cr>", {
  desc = "Description",
  silent = true,
  noremap = true,
})
```

### Function Callback

```lua
set("n", "<leader>xx", function()
  -- Lua code here
  require("plugin").action()
end, { desc = "Action" })
```

### Multiple Modes

```lua
set({ "n", "v" }, "<leader>xx", "<cmd>Command<cr>", { desc = "Works in normal and visual" })
```

### Buffer-Local

```lua
set("n", "<leader>xx", "<cmd>Command<cr>", { buffer = bufnr, desc = "Buffer local" })
```

### Delete Keymap

```lua
vim.keymap.del("n", "<leader>xx")
```

## Which-Key Integration

### Add Group Label

```lua
local wk = require("which-key")

wk.add({
  { "<leader>x", group = "Group Name" },
})
```

### With Icon

```lua
wk.add({
  { "<leader>a", group = "AI", icon = { icon = " ", color = "green" } },
})
```

### Multiple Groups

```lua
wk.add({
  { "<leader>a", group = "AI", icon = { icon = " ", color = "green" } },
  { "<leader>j", group = "Jump", icon = { icon = " ", color = "blue" } },
})
```

## NOE.ED Custom Keymaps

From `lua/config/keymaps.lua`:

### Modal Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `jj` | Insert | Exit to normal mode |
| `jk` | Insert | Exit to normal mode |
| `U` | Normal | Redo |
| `gh` | Normal/Visual | Go to line start |
| `gl` | Normal/Visual | Go to line end |
| `<Enter>` | Normal | Toggle fold |

### Line Movement

| Key | Mode | Action |
|-----|------|--------|
| `<A-j>` or `<A-Down>` | Normal/Insert/Visual | Move line down |
| `<A-k>` or `<A-Up>` | Normal/Insert/Visual | Move line up |
| `<A-C-Down>` | Normal | Duplicate line down |
| `<A-C-Up>` | Normal | Duplicate line up |

### Indentation

| Key | Mode | Action |
|-----|------|--------|
| `<C-]>` | Normal/Insert | Indent right |
| `<C-[>` | Normal/Insert | Indent left |

### Window Navigation

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |
| `<C-l>` | Move to right window |
| `<leader>wh` | Move to left window |
| `<leader>wj` | Move to lower window |
| `<leader>wk` | Move to upper window |
| `<leader>wl` | Move to right window |

### File Operations

| Key | Action |
|-----|--------|
| `<leader>fs` | Save file |
| `<leader>fS` | Save without formatting |
| `<C-a>` | Select all |

### Search

| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |

### Terminal

| Key | Action |
|-----|--------|
| `` <C-`> `` | Toggle terminal |

### Claude Code (AI)

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume Claude |
| `<leader>ab` | Add buffer to context |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit (borderless) |

### Navigation

| Key | Action |
|-----|--------|
| `<leader>jj` | Flash jump |

### Inlay Hints

| Key | Action |
|-----|--------|
| `<leader>ih` | Toggle inlay hints |

## LazyVim Default Keymaps

### Essential LazyVim Keys

| Key | Action |
|-----|--------|
| `<leader>` | Space (leader key) |
| `<leader>l` | Lazy plugin manager |
| `<leader>e` | Explorer (snacks) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>/` | Search in buffer |
| `<leader>xx` | Diagnostics |
| `<leader>cr` | Rename |
| `<leader>ca` | Code action |
| `<leader>cf` | Format |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover |
| `[d` / `]d` | Prev/next diagnostic |
| `[b` / `]b` | Prev/next buffer |

### Buffer Management

| Key | Action |
|-----|--------|
| `<leader>bb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |

### Window Management

| Key | Action |
|-----|--------|
| `<leader>ww` | Other window |
| `<leader>wd` | Delete window |
| `<leader>w-` | Split below |
| `<leader>w\|` | Split right |
| `<leader>-` | Split below |
| `<leader>\|` | Split right |

## Adding New Keymaps

### In keymaps.lua

```lua
-- lua/config/keymaps.lua
local set = vim.keymap.set
local wk = require("which-key")

-- Add a simple keymap
set("n", "<leader>xx", "<cmd>SomeCommand<cr>", { desc = "Description" })

-- Add a which-key group
wk.add({
  { "<leader>x", group = "My Group", icon = { icon = "X", color = "red" } },
})
```

### In Plugin Spec

```lua
return {
  "plugin/name",
  keys = {
    { "<leader>px", "<cmd>PluginAction<cr>", desc = "Plugin Action" },
    { "<leader>py", function() require("plugin").thing() end, desc = "Thing" },
  },
}
```

### Conditional Keymaps

```lua
set("n", "<leader>xx", function()
  if vim.bo.filetype == "lua" then
    -- Lua specific action
  else
    -- Default action
  end
end, { desc = "Conditional action" })
```

### Buffer-Specific (in autocmd)

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", { buffer = true, desc = "Go Test" })
  end,
})
```
