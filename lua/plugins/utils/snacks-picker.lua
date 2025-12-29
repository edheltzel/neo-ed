return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = "default",
      sources = {
        files = {
          hidden = true,
        },
        grep = {
          hidden = true, -- search hidden files
        },
        explorer = {
          hidden = true,
          trash = true,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },
}
