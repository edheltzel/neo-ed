-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
local g = vim.g

g.codeium_os = "Darwin"
g.codeium_arch = "arm64"

-- Set CARGO_TARGET_DIR for Mason LSP installations
vim.fn.setenv("CARGO_TARGET_DIR", vim.fn.stdpath("cache") .. "/cargo-target")

opt.cursorline = true
opt.cursorcolumn = true

opt.wrap = true

opt.swapfile = false
opt.backup = false

opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
opt.undofile = true

opt.spell = true
opt.spelllang = "en_us"
