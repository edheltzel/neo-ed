return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()`, and required for `toggle()` — otherwise optional
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `opts.auto_reload`
    vim.opt.autoread = true

    -- Recommended/example keymaps
    vim.keymap.set("n", "<leader>aot", function()
      require("opencode").toggle()
    end, { desc = "Toggle embedded" })
    vim.keymap.set("n", "<leader>aoa", function()
      require("opencode").ask("@cursor: ")
    end, { desc = "Ask OpenCode about this" })
    vim.keymap.set("v", "<leader>aoa", function()
      require("opencode").ask("@selection: ")
    end, { desc = "Ask OpenCode about selection" })
    vim.keymap.set("n", "<leader>ao+", function()
      require("opencode").prompt("@buffer", { append = true })
    end, { desc = "Add buffer to prompt" })
    vim.keymap.set("v", "<leader>ao+", function()
      require("opencode").prompt("@selection", { append = true })
    end, { desc = "Add selection to prompt" })
    vim.keymap.set("n", "<leader>aoe", function()
      require("opencode").prompt("Explain @cursor and its context")
    end, { desc = "Explain this code" })
    vim.keymap.set("n", "<leader>aon", function()
      require("opencode").command("session_new")
    end, { desc = "New session" })
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("messages_half_page_up")
    end, { desc = "Messages half page up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("messages_half_page_down")
    end, { desc = "Messages half page down" })
    vim.keymap.set({ "n", "v" }, "<leader>aos", function()
      require("opencode").select()
    end, { desc = "Select prompt" })
  end,
}
