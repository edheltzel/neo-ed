return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<C-c>", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude Code", mode = { "n", "t", "x" } },
  },
  opts = {
    terminal_cmd = "claude --dangerously-skip-permissions",
    terminal = {
      snacks_win_opts = {
        position = "float",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        keys = {
          claude_hide = {
            "<C-c>",
            function(self)
              self:hide()
            end,
            mode = "t",
            desc = "Hide Claude",
          },
        },
      },
    },
  },
}
