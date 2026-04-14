local function open_project(path)
  vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.expand(path)))
  local ok, persistence = pcall(require, "persistence")
  if ok and vim.fn.filereadable(persistence.current()) == 1 then
    persistence.load()
  else
    vim.cmd("edit .")
  end
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        keys = {
          {
            icon = " ",
            key = "o",
            desc = "Find Session",
            action = function()
              require("persistence").select()
            end,
          },
          {
            icon = "⊙ ",
            key = "d",
            desc = "DOTFILES",
            action = function()
              open_project("~/.dotfiles")
            end,
          },
          {
            icon = " ",
            key = "v",
            desc = "NOE.ED",
            action = function()
              open_project("~/.dotfiles/neoed/.config/nvim")
            end,
          },
          {
            icon = " ",
            key = "n",
            desc = "FieldNotes✱",
            action = function()
              open_project("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/FieldNotes✱")
            end,
          },
          { icon = "󰒲 ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
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
