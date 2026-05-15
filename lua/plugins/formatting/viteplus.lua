-- Vite+ / Oxfmt formatting.
-- Vite+ is the source of truth for JS/TS/React formatting; Prettier and Biome are intentionally not wired.

local viteplus_filetypes = {
  "astro",
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "svelte",
  "toml",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

local function has_vp()
  return vim.fn.executable("vp") == 1
end

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      opts.formatters.viteplus_oxfmt = {
        command = "vp",
        args = { "exec", "oxfmt", "--stdin-file-path", "$FILENAME" },
        stdin = true,
        condition = function()
          return has_vp()
        end,
      }

      opts.formatters.oxfmt = {
        command = "oxfmt",
        args = { "--stdin-file-path", "$FILENAME" },
        stdin = true,
      }

      for _, ft in ipairs(viteplus_filetypes) do
        opts.formatters_by_ft[ft] = { "viteplus_oxfmt", "oxfmt", stop_after_first = true }
      end

      opts.formatters_by_ft.yaml = { "viteplus_oxfmt", "oxfmt", "yamlfmt", stop_after_first = true }

      opts.format_on_save = opts.format_on_save or {
        timeout_ms = 2000,
        lsp_format = "fallback",
      }
    end,
  },
}
