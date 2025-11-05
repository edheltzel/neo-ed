return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      -- Default options
      windowCreationCommand = "vsplit", -- How to create the window (vsplits the window)
      transient = false, -- Makes the window transient (closes when you leave it)
      normalModeSearch = false, -- Start in normal mode search
      maxWorkers = 4, -- Max number of workers to use for search/replace
      -- Search options
      searchOptions = {
        -- Include hidden files by default
        includeHidden = true,
      },
    },
  },
}