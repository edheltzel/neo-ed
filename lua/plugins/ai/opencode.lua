return {
  "NickvanDyke/opencode.nvim",
  event = "VeryLazy",
  dependencies = {
    -- Recommended for `ask()`, and required for `toggle()` — otherwise optional
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = {
        snacks = {
          auto_close = true,
          win = {
            style = "terminal",
            position = "float",
            width = 0.8,
            height = 0.8,
            border = "rounded",
            enter = true,
          },
        },
      },
    }

    -- Required for `opts.auto_reload`
    vim.opt.autoread = true
    local set = vim.keymap.set
    -- Recommended/example keymaps
    -- <D> = Cmd --> use Ghostty for this
    set({ "n", "t", "x" }, "<D-A-C-o>", function()
      require("opencode").toggle()
    end, { desc = "Toggle OpenCode" })
    set("n", "<leader>aoo", function()
      require("opencode").toggle()
    end, { desc = "Toggle OpenCode" })
    set("n", "<leader>aoa", function()
      require("opencode").ask("@cursor: ")
    end, { desc = "Ask OpenCode about this" })
    set("v", "<leader>aoa", function()
      require("opencode").ask("@selection: ")
    end, { desc = "Ask OpenCode about selection" })
    set("n", "<leader>ao+", function()
      require("opencode").prompt("@buffer", { append = true })
    end, { desc = "Add buffer to prompt" })
    set("v", "<leader>aos", function()
      require("opencode").prompt("@selection", { append = true })
    end, { desc = "Add selection to prompt" })
    set("n", "<leader>aoe", function()
      require("opencode").prompt("Explain @cursor and its context")
    end, { desc = "Explain this code" })
    set("n", "<leader>aon", function()
      require("opencode").command("session_new")
    end, { desc = "New session" })
    set("n", "<S-C-u>", function()
      require("opencode").command("messages_half_page_up")
    end, { desc = "Messages half page up" })
    set("n", "<S-C-d>", function()
      require("opencode").command("messages_half_page_down")
    end, { desc = "Messages half page down" })
    set({ "n", "v" }, "<leader>aop", function()
      require("opencode").select()
    end, { desc = "Select prompt" })
  end,
}
