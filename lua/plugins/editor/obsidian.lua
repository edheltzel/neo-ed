return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = function()
    return {
      legacy_commands = false, -- this will be removed in the next major release
      workspaces = {
        {
          name = "FieldNotes✱",
          path = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/FieldNotes✱ ",
        },
      },
    }
  end,
}
