return {
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    cmd = { "Laravel" },
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>LL",
        function()
          Laravel.pickers.laravel()
        end,
        desc = "Laravel: Open Laravel Picker",
      },
      {
        "<c-g>",
        function()
          Laravel.commands.run("view:finder")
        end,
        desc = "Laravel: Open View Finder",
      },
      {
        "<leader>La",
        function()
          Laravel.pickers.artisan()
        end,
        desc = "Laravel: Open Artisan Picker",
      },
      {
        "<leader>Lt",
        function()
          Laravel.commands.run("actions")
        end,
        desc = "Laravel: Open Actions Picker",
      },
      {
        "<leader>Lr",
        function()
          Laravel.pickers.routes()
        end,
        desc = "Laravel: Open Routes Picker",
      },
      {
        "<leader>Lh",
        function()
          Laravel.run("artisan docs")
        end,
        desc = "Laravel: Open Documentation",
      },
      {
        "<leader>Lm",
        function()
          Laravel.pickers.make()
        end,
        desc = "Laravel: Open Make Picker",
      },
      {
        "<leader>Lc",
        function()
          Laravel.pickers.commands()
        end,
        desc = "Laravel: Open Commands Picker",
      },
      {
        "<leader>Lo",
        function()
          Laravel.pickers.resources()
        end,
        desc = "Laravel: Open Resources Picker",
      },
      {
        "<leader>Lp",
        function()
          Laravel.commands.run("command_center")
        end,
        desc = "Laravel: Open Command Center",
      },
    },
    opts = {
      lsp_server = "intelephense",
      features = {
        pickers = {
          enable = true,
          provider = "snacks",
        },
      },
    },
  },
}
