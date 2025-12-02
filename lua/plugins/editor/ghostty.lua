-- Ghostty terminal config syntax highlighting
-- Uses tree-sitter-ghostty plugin which self-registers with nvim-treesitter
return {
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
    ft = "ghostty",
  },
}
