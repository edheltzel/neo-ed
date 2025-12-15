return {
  "nvim-mini/mini.surround",
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
    custom_surroundings = {
      -- Use 'e' for emphasis/bold in Markdown: gsae, gsde, gsre
      e = {
        input = { "%*%*().-()%*%*" },
        output = { left = "**", right = "**" },
      },
      -- Use 'h' for highlight in Markdown: gsah, gsdh, gsrh
      h = {
        input = { "==().-()==" },
        output = { left = "==", right = "==" },
      },
    },
  },
}
