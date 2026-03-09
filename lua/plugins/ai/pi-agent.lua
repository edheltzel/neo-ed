return {
  "pablopunk/pi.nvim",
  event = "VeryLazy",
  keys = {
    -- Floating Terminal toggles
    {
      "<D-A-C-p>",
      function()
        Snacks.terminal.toggle("pi", {
          win = {
            position = "float",
            width = 0.8,
            height = 0.8,
            border = "rounded",
          },
        })
      end,
      desc = "Toggle Pi Terminal",
      mode = { "n", "t", "x" },
    },
    {
      "<leader>app",
      function()
        Snacks.terminal.toggle("pi", {
          win = {
            position = "float",
            width = 0.8,
            height = 0.8,
            border = "rounded",
          },
        })
      end,
      desc = "Toggle Pi Terminal",
      mode = "n",
    },
    -- Native pi.nvim commands (inline)
    {
      "<leader>apa",
      "<cmd>PiAsk<cr>",
      desc = "Ask Pi (inline)",
      mode = "n",
    },
    {
      "<leader>apa",
      "<cmd>PiAskSelection<cr>",
      desc = "Ask Pi (inline selection)",
      mode = "v",
    },
  },
  opts = {
    provider = "opencode",
    model = "gemini-3.1-pro",
  },
}
