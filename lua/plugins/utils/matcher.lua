return {
  {
    "ankushbhagats/match.nvim",
    config = true,
    cmd = { "Match", "MatchWord", "MatchLine" },
    keys = {
      { "<leader>sf", "<cmd>Match<cr>", mode = { "n", "x" }, desc = "Match (Search & Replace)" },
    },
  },
}
