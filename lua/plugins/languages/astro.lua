return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "astro", "css" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.astro = {}

      opts.servers.vtsls = opts.servers.vtsls or {}
      opts.servers.vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@astrojs/ts-plugin",
              location = vim.env.MASON .. "/packages/" .. "astro-language-server" .. "/node_modules/@astrojs/ts-plugin",
              enableForWorkspaceTypeScriptVersions = true,
            },
          },
        },
      }
    end,
  },

  -- Formatting handled in plugins/formatting/viteplus.lua (uses Vite+/Oxfmt for astro)
}
