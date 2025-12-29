-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
local g = vim.g
local o = vim.o
o.timeoutlen = 250

g.codeium_arch = "arm64"
g.codeium_os = "Darwin"

opt.cursorline = true
opt.cursorcolumn = true
opt.scrolloff = 999

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
