-- https://github.com/eldritch-theme/eldritch.nvim
-- I also contrubite to the vscode theme https://github.com/eldritch-theme/vscode
return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      dim_inactive = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = {
        "qf",
        "help",
        "terminal",
      },
      -- on_colors = function(colors)
      --   local original_bg = colors.bg
      --   -- colors.bg_dark = "#0f101a"
      --   colors.bg_dark = "#212337"
      --   colors.bg = "#171928"
      -- end,
    },
  },
}
