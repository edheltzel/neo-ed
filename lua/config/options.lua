-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Terminal background sync (OSC 11/111) - eliminates padding gap around Neovim
-- Must be set BEFORE colorscheme loads to work on initial UIEnter
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if normal.bg then
      io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end
  end,
  desc = "Sync terminal background with Neovim colorscheme",
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    io.write("\027]111\027\\")
  end,
  desc = "Reset terminal background on exit",
})

local opt = vim.opt
local g = vim.g
local o = vim.o
o.timeoutlen = 250

g.codeium_arch = "arm64"
g.codeium_os = "Darwin"
g.loaded_python3_provider = 0

opt.cursorline = true
opt.cursorcolumn = true
opt.scrolloff = 999

opt.linespace = 2
opt.textwidth = 80
opt.colorcolumn = "80"
opt.wrap = true

opt.swapfile = false
opt.backup = false

opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"

opt.spell = false
opt.spelllang = "en_us"

g.lazygit_config = false
