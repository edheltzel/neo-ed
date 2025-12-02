# LSP Configuration

## Table of Contents

1. [LSP Architecture](#lsp-architecture)
2. [Server Configuration](#server-configuration)
3. [Mason Integration](#mason-integration)
4. [TreeSitter Setup](#treesitter-setup)
5. [Formatters & Linters](#formatters--linters)
6. [NOE.ED Language Examples](#noeed-language-examples)

## LSP Architecture

NOE.ED uses LazyVim's LSP setup:

1. **nvim-lspconfig** - Core LSP client configuration
2. **mason.nvim** - LSP server installer
3. **mason-lspconfig.nvim** - Bridge between Mason and lspconfig
4. **nvim-treesitter** - Syntax highlighting and parsing

## Server Configuration

### Basic Server Setup

Create `lua/plugins/languages/langname.lua`:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        servername = {},  -- Use defaults
      },
    },
  },
}
```

### Server with Settings

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        servername = {
          settings = {
            servername = {  -- Note: nested under server name
              option = "value",
              nested = { key = true },
            },
          },
        },
      },
    },
  },
}
```

### Server with Custom Keys

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        servername = {
          keys = {
            { "<leader>co", "<cmd>ServerCommand<cr>", desc = "Server Action" },
          },
        },
      },
    },
  },
}
```

### Custom Setup Function

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        servername = { settings = {} },
      },
      setup = {
        servername = function(_, opts)
          -- Custom initialization logic
          require("lspconfig").servername.setup(opts)
          return true  -- Return true to skip default setup
        end,
      },
    },
  },
}
```

### Using Snacks LSP Hooks

```lua
setup = {
  servername = function(_, opts)
    Snacks.util.lsp.on({ name = "servername" }, function(_, client)
      -- Runs when client attaches
      client.server_capabilities.someCapability = false
    end)
  end,
}
```

## Mason Integration

### Ensure Tools Installed

```lua
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "gofumpt",
        "goimports",
        "delve",
      })
    end,
  },
}
```

### Mason Commands

- `:Mason` - Open Mason UI
- `:MasonInstall <package>` - Install package
- `:MasonUninstall <package>` - Remove package
- `:MasonLog` - View logs

## TreeSitter Setup

### Add Parsers

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
    },
  },
}
```

### TreeSitter Options

```lua
opts = {
  ensure_installed = { "lua", "python" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}
```

## Formatters & Linters

### Conform (Formatting)

```lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      go = { "goimports", "gofumpt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      -- Custom formatter config
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
}
```

### nvim-lint (Linting)

```lua
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "ruff" },
      javascript = { "eslint" },
    },
  },
}
```

### Biome (Format + Lint)

NOE.ED uses Biome for JS/TS via LazyVim extra:
`lazyvim.plugins.extras.formatting.biome`

## NOE.ED Language Examples

### Go (lua/plugins/languages/go.lua)

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
      -- Fix semantic tokens issue
      setup = {
        gopls = function(_, _)
          Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
            client.server_capabilities.semanticTokensProvider = nil
          end)
        end,
      },
    },
  },
}
```

### Python (lua/plugins/languages/python.lua)

Key patterns:
- Multiple LSP server handling (pyright vs basedpyright)
- Ruff integration for linting/formatting
- Virtual environment selection for DAP

```lua
-- Server selection pattern
local lsp = "basedpyright"  -- or "pyright"
local ruff = "ruff"

opts = function(_, opts)
  local servers = { "pyright", "basedpyright", "ruff", "ruff_lsp" }
  for _, server in ipairs(servers) do
    opts.servers[server] = opts.servers[server] or {}
    opts.servers[server].enabled = server == lsp or server == ruff
  end
end
```

### TypeScript (lua/plugins/languages/typescript.lua)

Key patterns:
- vtsls as primary TS server
- Custom commands (organize imports, move to file)
- DAP configuration for Node debugging

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
            },
          },
          keys = {
            { "<leader>co", "<cmd>VtsExec organize_imports<cr>", desc = "Organize Imports" },
          },
        },
      },
    },
  },
}
```

## Common LSP Commands

- `:LspInfo` - Show active LSP clients
- `:LspStart` - Start LSP for current buffer
- `:LspStop` - Stop LSP client
- `:LspRestart` - Restart LSP client
- `<leader>cl` - LSP info (LazyVim default)
- `<leader>cf` - Format document
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>cr` - Rename symbol
