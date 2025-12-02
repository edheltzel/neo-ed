# Troubleshooting Guide

## Table of Contents

1. [Common Errors](#common-errors)
2. [LSP Issues](#lsp-issues)
3. [Plugin Issues](#plugin-issues)
4. [Performance Issues](#performance-issues)
5. [Diagnostic Commands](#diagnostic-commands)

## Common Errors

### "module 'x' not found"

**Cause:** Plugin not installed or wrong require path.

**Solutions:**
1. Run `:Lazy sync` to install missing plugins
2. Check spelling in require statement
3. Verify plugin is in a spec file under `lua/plugins/`

### "attempt to index nil value"

**Cause:** Accessing property of nil (plugin not loaded or wrong API).

**Solutions:**
1. Wrap in pcall: `local ok, mod = pcall(require, "module")`
2. Check plugin documentation for correct API
3. Ensure plugin has loaded (check lazy loading events)

### "Invalid option: 'x'"

**Cause:** Vim option doesn't exist or typo.

**Solutions:**
1. Check `:help 'optionname'`
2. Use `vim.opt` for vim options, not plugin options
3. Verify Neovim version supports the option

### Keymap Not Working

**Causes & Solutions:**
1. **Conflict:** Check `:map <key>` to see what's bound
2. **Wrong mode:** Verify mode in set() is correct (n/i/v/x)
3. **Plugin overriding:** Plugin keys may override config keys - set in plugin spec
4. **Typo in command:** Check command exists with `:Command`

## LSP Issues

### LSP Not Starting

1. Check LSP status:
   ```
   :LspInfo
   ```

2. Verify server installed:
   ```
   :Mason
   ```

3. Check server logs:
   ```
   :LspLog
   ```

4. Manual start:
   ```
   :LspStart servername
   ```

### LSP Not Finding Root

**Cause:** Server can't detect project root.

**Solution:** Check root patterns in server config:
```lua
servers = {
  servername = {
    root_dir = require("lspconfig.util").root_pattern("marker.file", ".git"),
  },
}
```

### Formatting Not Working

1. Check formatter assigned:
   ```
   :ConformInfo
   ```

2. Verify formatter installed:
   ```
   :Mason
   ```

3. Check for errors:
   ```lua
   require("conform").format({ async = false, lsp_fallback = true })
   ```

4. Specific formatter config in `lua/plugins/formatting/conform.lua`

### Semantic Tokens Issues (gopls)

**Symptom:** Highlighting conflicts with TreeSitter.

**Solution:** NOE.ED disables gopls semantic tokens:
```lua
setup = {
  gopls = function(_, _)
    Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
      client.server_capabilities.semanticTokensProvider = nil
    end)
  end,
}
```

### Inlay Hints Not Showing

1. Toggle hints: `<leader>ih` or `:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())`
2. Check server supports hints
3. Verify inlay hint settings in server config

## Plugin Issues

### Plugin Not Loading

1. Check lazy loading conditions:
   ```
   :Lazy
   ```
   Look for plugin status (loaded/not loaded)

2. Verify spec is correct:
   - File is in `lua/plugins/` or subdirectory
   - Returns a table
   - Plugin name is correct (author/repo)

3. Force load:
   ```
   :Lazy load plugin-name
   ```

### Plugin Conflicts

1. Identify conflicting plugins:
   - Check keymaps: `:map <key>`
   - Check autocmds: `:autocmd`

2. Adjust load order in `lua/config/lazy.lua`

3. Disable one plugin temporarily:
   ```lua
   { "plugin/name", enabled = false }
   ```

### Lazy.nvim Errors

1. Clear cache:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.local/state/nvim/lazy
   ```

2. Reinstall:
   ```
   :Lazy restore
   ```

3. Update lockfile:
   ```
   :Lazy update
   ```

### LazyVim Extra Not Working

1. Verify enabled in `lazyvim.json`
2. Run `:LazyExtras` and toggle
3. Restart Neovim after changes

## Performance Issues

### Slow Startup

1. Profile startup:
   ```
   nvim --startuptime startup.log
   ```

2. Check lazy loading:
   ```
   :Lazy profile
   ```

3. Common fixes:
   - Use `event = "VeryLazy"` for non-essential plugins
   - Use `ft = {}` for language-specific plugins
   - Use `keys = {}` for rarely used plugins

### Slow File Opening

1. Check for large files - Snacks bigfile should handle this
2. Disable heavy plugins for specific filetypes
3. Check TreeSitter parsers aren't stuck

### High CPU During Editing

1. Check LSP server:
   ```
   :LspInfo
   ```

2. Disable problematic LSP features:
   ```lua
   servers = {
     servername = {
       capabilities = {
         documentHighlightProvider = false,
       },
     },
   }
   ```

3. Check for autocmd loops in `:autocmd`

## Diagnostic Commands

### Essential Commands

| Command | Purpose |
|---------|---------|
| `:checkhealth` | Overall health check |
| `:Lazy` | Plugin manager UI |
| `:Lazy health` | Plugin health |
| `:Lazy profile` | Startup profiling |
| `:LspInfo` | LSP client status |
| `:LspLog` | LSP server logs |
| `:Mason` | Package manager UI |
| `:ConformInfo` | Formatter info |
| `:LazyExtras` | Toggle LazyVim extras |

### Debug Mode

Start Neovim with minimal config:
```bash
nvim --clean
```

Or with only LazyVim:
```bash
nvim -u NONE -c "lua require('config.lazy')"
```

### Log Locations

- LSP logs: `~/.local/state/nvim/lsp.log`
- Lazy.nvim: `~/.local/state/nvim/lazy/`
- Neovim: `~/.local/state/nvim/`

### Useful Lua Debugging

```lua
-- Print value
vim.print(variable)

-- Inspect table
print(vim.inspect(table))

-- Notify
vim.notify("Message", vim.log.levels.INFO)

-- Check if plugin loaded
print(package.loaded["plugin"])

-- Get plugin config
print(vim.inspect(require("lazy.core.config").spec.plugins["plugin-name"]))
```

### Reset Everything

```bash
# Backup first!
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
# Then restart Neovim - plugins will reinstall
```
