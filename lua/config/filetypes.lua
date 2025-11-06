-- Custom filetype associations
vim.filetype.add({
  extension = {
    njk = "htmldjango", -- Use htmldjango for Nunjucks (includes HTML + Jinja)
    -- Add more file extensions here
  },
  filename = {
    -- Example: [".env.local"] = "sh",
    [".*%.env%.*%"] = "sh",
  },
  pattern = {
    -- Example: [".*%.blade%.php"] = "blade",
  },
})
