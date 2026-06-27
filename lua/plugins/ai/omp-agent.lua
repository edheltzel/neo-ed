local function toggle_omp(command)
  Snacks.terminal.toggle(command or "omp", {
    win = {
      position = "float",
      width = 0.8,
      height = 0.8,
      border = "rounded",
    },
  })
end

local function open_omp_with_buffer()
  local path = vim.fn.expand("%:p")
  if path == "" then
    vim.notify("No file-backed buffer to send to OMP", vim.log.levels.WARN)
    return
  end

  toggle_omp("omp @" .. vim.fn.shellescape(path))
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<D-C-o>",
      function()
        toggle_omp()
      end,
      desc = "Toggle OMP Terminal",
      mode = { "n", "t", "x" },
    },
    {
      "<C-A-o>",
      function()
        toggle_omp()
      end,
      desc = "Toggle OMP Terminal",
      mode = { "n", "t", "x" },
    },
    {
      "<leader>ao",
      function()
        toggle_omp()
      end,
      desc = "Toggle OMP",
      mode = "n",
    },
    {
      "<leader>aO",
      open_omp_with_buffer,
      desc = "Open OMP with current buffer",
      mode = "n",
    },
  },
}
