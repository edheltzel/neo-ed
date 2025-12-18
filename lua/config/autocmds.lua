-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local api = vim.api

-- highlight YAML frontmatter
api.nvim_create_autocmd("FileType", {
  pattern = { "htmldjango", "jinja", "htmldjango", "njk", "nunjucks", "twig", "liquid" },
  callback = function()
    vim.cmd([[
    syntax include @YAML syntax/yaml.vim
    syntax region yamlFrontmatter start=/^---$/ end=/^---$/ keepend contains=@YAML
    ]])
  end,
})

-- open help in a vertical split
api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- resize splits automatically when terminal window is resized
api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- disables auto comment on new line
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- dotenv syntax highlighting
api.nvim_create_autocmd("BufRead", {
  group = api.nvim_create_augroup("dotenv_ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

-- Configure markdownlint-cli2 to use global config
api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.md",
  once = true,
  callback = function()
    local ok, lint = pcall(require, "lint")
    if ok and lint.linters["markdownlint-cli2"] then
      lint.linters["markdownlint-cli2"].args = {
        "--config",
        vim.fn.expand("~/.config/markdownlint-cli2/config.yaml"),
      }
    end
  end,
})
