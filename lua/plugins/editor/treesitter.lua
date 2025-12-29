vim.treesitter.language.register("json", "jsonc")

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "fish",
      "go",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "rust",
      "typescript",
      "yaml",
    },
  },
}
