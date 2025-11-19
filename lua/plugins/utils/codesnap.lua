return {
  "mistricky/codesnap.nvim",
  event = "VeryLazy",
  build = "make",
  config = function()
    require("codesnap").setup({
      watermark = "",
    })
  end,
}
