-- Hybrid Biome + Prettier configuration
-- Biome is the primary formatter (enabled via LazyVim extra: lazyvim.plugins.extras.formatting.biome)
-- Prettier is fallback for filetypes Biome doesn't support (HTML, YAML, Markdown, etc.)

-- Filetypes that need Prettier (not supported by Biome)
local prettier_only = {
  "handlebars",
  "html",
  "less",
  "markdown",
  "scss",
  "yaml",
}

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Add Prettier for filetypes Biome doesn't support
      for _, ft in ipairs(prettier_only) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettier")
      end

      opts.formatters = opts.formatters or {}

      -- Configure Biome to use global config as fallback
      opts.formatters.biome = {
        require_cwd = false, -- Allow formatting without biome.json in project
        env = {
          BIOME_CONFIG_PATH = vim.fn.expand("~"),
        },
      }

      -- Configure Prettier with sensible defaults
      opts.formatters.prettier = {
        prepend_args = {
          "--tab-width=2",
          "--print-width=100",
        },
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.prettier.with({
        filetypes = prettier_only,
      }))
    end,
  },
}
