return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  opts = {
    terminal_cmd = "claude --dangerously-skip-permissions",
    terminal = {
      split_side = "left",
      split_width_percentage = 0.20,
    },
  },
}
