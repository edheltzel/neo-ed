return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "FieldNotes✱",
          path = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/FieldNotes✱ ",
        },
      },
      daily_notes = {
        folder = "TheLog",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "New-DailyLog.md",
      },
      templates = {
        folder = "Attachments/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
          date_long = function()
            return os.date("%A, %B %d, %Y")
          end,
        },
      },
    })
  end,
}
