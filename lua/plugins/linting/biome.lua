-- Biome LSP for linting
-- Provides real-time diagnostics for JS/TS/JSON/etc.
-- Replaces ESLint with Biome's built-in linter

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable ESLint LSP (replaced by Biome)
        eslint = {
          enabled = false,
        },
        -- Enable Biome LSP for linting
        biome = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Look for biome.json, package.json, or git root
            return util.root_pattern("biome.json", "biome.jsonc")(fname)
              or util.root_pattern("package.json", ".git")(fname)
              or vim.fn.expand("~") -- Fallback to home directory (uses global config)
          end,
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "biome" } },
  },
}
