return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>aD", "<cmd>ClaudeCode --dangerously-skip-permissions<cr>", desc = "Run Dangerously" },
  },
}
