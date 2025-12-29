return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "N", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('')" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "o",
            desc = "Find Session",
            action = function()
              require("persistence").select()
            end,
          },
          { icon = "⊙ ", key = "d", desc = "DOTFILES", action = ":cd ${HOME}/.dotfiles | :e ." },
          { icon = " ", key = "v", desc = "NOE.ED", action = ":cd ${HOME}/.dotfiles/neoed/.config/nvim | :e ." },
          {
            icon = "󰎞 ",
            key = "n",
            desc = "FieldNotes✱",
            action = ":cd ${HOME}/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/FieldNotes✱\\  | :e .",
          },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
        ███╗   ██╗███████╗ ██████╗    ███████╗██████╗
        ████╗  ██║██╔════╝██╔═══██╗   ██╔════╝██╔══██╗
        ██╔██╗ ██║█████╗  ██║   ██║   █████╗  ██║  ██║
        ██║╚██╗██║██╔══╝  ██║   ██║   ██╔══╝  ██║  ██║
        ██║ ╚████║███████╗╚██████╔╝██╗███████╗██████╔╝
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝╚══════╝╚═════╝ ]],
      },
    },
  },
}
