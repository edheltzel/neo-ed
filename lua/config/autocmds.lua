-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- YAML front-matter highlighting for Nunjucks/Jinja templates
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "htmldjango", "jinja" },
  callback = function()
    -- Add YAML syntax highlighting for front-matter regions
    vim.cmd([[
      syntax include @YAML syntax/yaml.vim
      syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@YAML
    ]])
  end,
})

---- found these gems youtube - https://youtu.be/v36vLiFVOXY?si=1SygS6SK6TGDa9UT
-- open help in a vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- resize splits automatically when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- disables auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- dotenv syntax highlighting
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})
