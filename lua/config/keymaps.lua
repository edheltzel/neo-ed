-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- KEY:
-- <M> = alt
-- <C> = ctrl
-- <leader> = space
-- <S> = shift
-- <CR> = carriage return
-- <D> = super/cmd

local set = vim.keymap.set
-- local del = vim.keymap.del
local opts = { noremap = true, silent = true }
local wk = require("which-key")
local Util = require("lazyvim.util")

local set_keymap = vim.api.nvim_set_keymap

-- UNSET EXISTING KEYMAPS
-- del({ "n", "i", "v" }, "<A-j>")
-- del({ "n", "i", "v" }, "<A-k>")
-- del("n", "<C-Left>")
-- del("n", "<C-Down>")
-- del("n", "<C-Up>")
-- del("n", "<C-Right")

-- General -------------------------------------------------------------------------------
-- Delete without yanking
set({ "n", "v" }, "<leader>d", "d", { noremap = true, silent = true, desc = "Delete without yanking" })
-- delete word by alt+backspace macos style
set({ "i", "c" }, "<A-BD>", "<C-w>", { noremap = true })
set("n", "<A-BS>", "db", { noremap = true })

-- redo with shift+u (U)
set("n", "U", "<C-r>", { noremap = true, silent = true, desc = "Redo" })
set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

---- Multiword/Cursors
set({ "n" }, "<C-n>", "*Ncgn", { noremap = true, silent = true, desc = "MultiWord editing use . to repeat" })

set("t", "<Esc>", "<C-\\><C-n>", opts) -- ESCAPE TERMINAL MODE

-- duplicate lines up/down
set("v", "<A-C-Up>", "y`>p`<", opts)
set("n", "<A-C-Up>", "Vy`>p`<", opts)
set("v", "<A-C-Down>", "y`<kp`>", opts)
set("n", "<A-C-Down>", "Vy`<p`>", opts)

set("v", "<A-C-d>", "y`<kp`>", opts)
set("n", "<A-C-d>", "Vy`<p`>", opts)

-- JUMP to BOL/EOL
set("n", "gh", "^", { noremap = true, silent = true, desc = "Jump beginning of line" })
set("n", "gl", "$", { noremap = true, silent = true, desc = "Jump end of line" })

-- CLEAR SEARCH HIGHLIGHTS
set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })
set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" }) -- shift+.
set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" }) -- shift+,

-- LINE BUBBLING - Move lines up/down
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

-- FIX: look into why ripgrep is not working with deafult keymap
set("n", "<leader>sr", ":GrugFar<CR>", { noremap = true, silent = true, desc = "Search & Replace" })

---- VSpaceCode-ish -----------------------------------------------------------------------------

---- save file
set("n", "<leader>fs", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("n", "<leader>fS", ":noautocmd w<CR>", { noremap = true, silent = true, desc = "Save without formatting" })

---- flash
wk.add({ { "<leader>j", group = "Flash Leap", icon = { icon = "⚡︎", color = "orange" } } })
set({ "n", "x", "o" }, "<leader>jj", function()
  require("flash").jump()
end, { noremap = true, silent = true, desc = "Jump to character" })

---- code folding
set("n", "<ENTER>", "za", { noremap = true, silent = true, desc = "Code Folding" })

---- terminal
set({ "n", "t" }, "<C-`>", function()
  Util.terminal(nil, { border = "none" })
end, { noremap = true, silent = true, desc = "Toggle terminal" })

---- Move around splits
set("n", "<leader>wh", "<C-w>h", { noremap = true, silent = true, desc = "switch window right" })
set("n", "<leader>wj", "<C-w>j", { noremap = true, silent = true, desc = "switch window down" })
set("n", "<leader>wk", "<C-w>k", { noremap = true, silent = true, desc = "switch window up" })
set("n", "<leader>wl", "<C-w>l", { noremap = true, silent = true, desc = "switch window left" })

---- with Ctrl
set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "switch window left" })
set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "switch window down" })
set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "switch window up" })
set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "switch window right" })

---- BORDERLESS LAZYGIT
set("n", "<leader>gg", function()
  Snacks.lazygit({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { noremap = true, silent = true, desc = "Lazygit (root dir)" })

-- AI Agents/Calude Code -------------------------------------------------------------------------------

wk.add({ { "<leader>a", group = "AI", icon = { icon = "", color = "yellow" } } })
