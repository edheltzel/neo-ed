-- Hybrid Biome + Prettier Formatting Configuration
-- Biome is the primary formatter for JS/TS/CSS/JSON
-- Prettier is the fallback when Biome isn't available or for unsupported filetypes
--
-- Formatter chain: { "biome", "prettier", stop_after_first = true }
-- This tries Biome first, falls back to Prettier if Biome fails/unavailable

-- Filetypes where Biome is primary with Prettier fallback
local biome_with_fallback = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "css",
  "graphql",
  "svelte",
  "vue",
}

-- Filetypes that only Prettier supports (Biome doesn't handle these)
local prettier_only = {
  "astro",
  "handlebars",
  "html",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
}

-- Filetypes with special formatters (not Prettier or Biome)
local special_formatters = {
  yaml = { "yamlfmt" },
}

return {
  -- Ensure formatters are installed via Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "prettier",
        "yamlfmt",
      },
    },
  },

  -- Main formatting configuration
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      -- Biome with Prettier fallback for supported filetypes
      for _, ft in ipairs(biome_with_fallback) do
        opts.formatters_by_ft[ft] = { "biome", "prettier", stop_after_first = true }
      end

      -- Prettier-only filetypes (Biome doesn't support these)
      for _, ft in ipairs(prettier_only) do
        opts.formatters_by_ft[ft] = { "prettier" }
      end

      -- Special formatters (yamlfmt for YAML, etc.)
      for ft, formatters in pairs(special_formatters) do
        opts.formatters_by_ft[ft] = formatters
      end

      -- Configure Biome formatter
      opts.formatters.biome = {
        require_cwd = false, -- Allow formatting without biome.json in project
        -- Use global config from home directory as fallback
        args = function(_, ctx)
          local args = { "format", "--stdin-file-path", "$FILENAME" }
          -- Check if project has local biome config
          local has_local_config =
            vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.dirname, upward = true, stop = vim.env.HOME })[1]
          -- If no local config, use global config
          if not has_local_config then
            local global_config = vim.fn.expand("~/biome.json")
            if vim.fn.filereadable(global_config) == 1 then
              table.insert(args, "--config-path")
              table.insert(args, vim.fn.expand("~"))
            end
          end
          return args
        end,
      }

      -- Configure Prettier with sensible defaults
      opts.formatters.prettier = {
        prepend_args = {
          "--tab-width=2",
          "--print-width=100",
        },
      }

      -- Configure yamlfmt for K8s-friendly YAML
      opts.formatters.yamlfmt = {
        prepend_args = { "-formatter", "indent=2,include_document_start=true" },
      }

      -- Enable format on save (LazyVim default, but explicit for clarity)
      -- opts.format_on_save = opts.format_on_save or {
      --   timeout_ms = 3000,
      --   lsp_fallback = true,
      -- }
    end,
  },

  -- None-ls integration (optional, for projects using null-ls)
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        nls.builtins.formatting.prettier.with({
          filetypes = prettier_only,
        })
      )
    end,
  },
}
