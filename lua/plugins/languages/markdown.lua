return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    -- auto add bullets
    "bullets-vim/bullets.vim",
    config = function()
      vim.g.buttlets_delete_last_bullet_if_empty = 2
    end,
  },
}
