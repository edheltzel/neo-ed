-- TreeSitter configuration
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Map jsonc filetype to use json parser (jsonc isn't a separate treesitter parser)
    vim.treesitter.language.register("json", "jsonc")
    return opts
  end,
}
