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
