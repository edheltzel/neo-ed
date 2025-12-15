-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local api = vim.api
local set = vim.keymap.set
local del = vim.keymap.del
local wk = require("which-key")
local Snacks = require("snacks")
local set_keymap = api.nvim_set_keymap

-- unset
del({ "n", "i", "v" }, "<A-k>")
del({ "n", "i", "v" }, "<A-j>")

--- -- ------------------------------------------------------
-- General -------------------------------------------------
-- -- ------------------------------------------------------
api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false, desc = "exit INSERT mode" })
api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false, desc = "exit INSERT mode" })

set({ "n", "v" }, "<leader>d", "d", { noremap = true, silent = true, desc = "Delete without yanking" })

set("n", "gh", "^", { noremap = true, silent = true, desc = "Jump beginning of line" })
set("n", "gl", "$", { noremap = true, silent = true, desc = "Jump end of line" })

set({ "i", "c" }, "<A-BD>", "<C-w>", { noremap = true, desc = "Delete word w/ alt-backspace" })
set("n", "<A-BS>", "db", { noremap = true, desc = "Delete word w/ alt-backspace" })

set("n", "U", "<C-r>", { noremap = true, silent = true, desc = "Redo w/ U" })
-- set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Escape terminal" })

-- duplicate lines up/down
set("v", "<A-C-Up>", "y`>p`<", { noremap = true, silent = true, desc = "duplicate lines up" })
set("n", "<A-C-Up>", "Vy`>p`<", { noremap = true, silent = true, desc = "duplicate lines up" })
set("v", "<A-C-Down>", "y`<kp`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("n", "<A-C-Down>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("n", "<A-C-d>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("v", "<A-C-d>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("n", "<A-C-j>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("v", "<A-C-j>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("n", "<A-C-l>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })
set("v", "<A-C-l>", "Vy`<p`>", { noremap = true, silent = true, desc = "duplicate lines down" })

set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })
set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" }) -- shift+.
set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" }) -- shift+,
---- move line down
set("n", "<A-down>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
set("v", "<A-down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
---- move line up
set("n", "<A-up>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
set("v", "<A-up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })
set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })
-- toggle terminal
set({ "n", "t" }, "<C-`>", function()
  Snacks.terminal(nil, { border = "none" })
end, { noremap = true, silent = true, desc = "Toggle terminal" })

---- move around splits
set("n", "<leader>wh", "<C-w>h", { noremap = true, silent = true, desc = "switch window right" })
set("n", "<leader>wj", "<C-w>j", { noremap = true, silent = true, desc = "switch window down" })
set("n", "<leader>wk", "<C-w>k", { noremap = true, silent = true, desc = "switch window up" })
set("n", "<leader>wl", "<C-w>l", { noremap = true, silent = true, desc = "switch window left" })
set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "switch window left" })
set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "switch window down" })
set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "switch window up" })
set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "switch window right" })
---- move around splits
set("n", "<leader>wh", "<C-w>h", { noremap = true, silent = true, desc = "switch window right" })

set("n", "<ENTER>", "za", { noremap = true, silent = true, desc = "Code Folding" })
-- indenting
set("n", "<C-]>", ">>", { noremap = true, silent = true, desc = "Indent right" })
set("n", "<C-[>", "<<", { noremap = true, silent = true, desc = "Indent left" })
set("v", "<C-]>", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })
set("v", "<C-[>", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
-- shift+.
set("n", ">", ">>", { noremap = true, silent = true, desc = "Indent right" })
set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })
-- shift+,
set("n", "<", "<<", { noremap = true, silent = true, desc = "Indent left" })
set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
-- jump to character like vspacecode
wk.add({ { "<leader>j", group = "Flash Leap", icon = { icon = "⚡︎", color = "orange" } } })
set({ "n", "x", "o" }, "<leader>jj", function()
  require("flash").jump()
end, { noremap = true, silent = true, desc = "Jump to character" })
-- save like vspacecode
set("n", "<leader>fs", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("n", "<leader>fS", ":noautocmd w<CR>", { noremap = true, silent = true, desc = "Save without formatting" })

-- toggle inlay hints
wk.add({ { "<leader>i", group = "Inlay Hints", icon = { icon = "ℹ", color = "orange" } } })
set("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay Hints Enabled" or "Inlay Hints Disabled")
end)

-- Claude Code
wk.add({ { "<leader>a", group = "Claude Code", icon = { icon = "🤖", color = "purple" } } })

-- Laravel
wk.add({ { "<leader>L", group = "Laravel", icon = { icon = "", color = "red" } } })

-- Move LazyVim changelog from <leader>L to <leader>l
set("n", "<leader>lc", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })
del("n", "<leader>L")

-- borderless lazygit
set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = vim.fn.getcwd(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { noremap = true, silent = true, desc = "Lazygit (root dir)" })

--------------------------------------------------------------------------------------------
---- MacOS CMD keymaps ---------------------------------------------------------------------
---- CSI u keyboard protocol must be supported by your terminal ----------------------------
--------------------------------------------------------------------------------------------
set("n", "<D-c>", '"+yiw', { noremap = true, silent = true, desc = "Copy word" })
set("v", "<D-c>", '"+y', { noremap = true, silent = true, desc = "Copy selection" })
set("n", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Paste" })
set("v", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Paste" })
set("i", "<D-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in insert mode" })
set("n", "<D-x>", '"+diw', { noremap = true, silent = true, desc = "Cut word" })
set("v", "<D-x>", '"+d', { noremap = true, silent = true, desc = "Cut selection" })
set("n", "<D-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("n", "<D-z>", "u", { noremap = true, silent = true, desc = "Undo" })
set("i", "<D-z>", "<C-o>u", { noremap = true, silent = true, desc = "Undo in insert mode" })
set("n", "<D-S-z>", "<C-r>", { noremap = true, silent = true, desc = "Redo" })
set("i", "<D-S-z>", "<C-o><C-r>", { noremap = true, silent = true, desc = "Redo in insert mode" })
set("n", "<D-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })
