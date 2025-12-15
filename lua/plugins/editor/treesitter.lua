-- Ensure common parsers are installed
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "jsonc", -- JSON with comments (used by tsconfig, VSCode settings, etc.)
    },
  },
}
