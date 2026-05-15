-- Vite+ / Oxlint diagnostics.
-- Biome and ESLint are deliberately disabled to avoid duplicate diagnostics.

local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "svelte",
  "astro",
}

local function parse_oxlint(output, bufnr)
  if output == nil or output == "" then
    return {}
  end

  local ok, decoded = pcall(vim.json.decode, output)
  if not ok or type(decoded) ~= "table" then
    return {}
  end

  local diagnostics = {}
  local items = decoded.diagnostics or decoded
  if type(items) ~= "table" then
    return diagnostics
  end

  local current = vim.api.nvim_buf_get_name(bufnr)

  for _, item in ipairs(items) do
    local labels = item.labels or {}
    local label = labels[1] or {}
    local span = label.span or item.span or item.location or {}
    local file = item.filename or item.file_path or item.path or span.file

    if not file or file == current or vim.fn.fnamemodify(file, ":p") == current then
      local line = span.line or item.line or 1
      local col = span.column or span.col or item.column or item.col or 1
      local severity = vim.diagnostic.severity.WARN
      local level = item.severity or item.level

      if level == "error" then
        severity = vim.diagnostic.severity.ERROR
      elseif level == "info" then
        severity = vim.diagnostic.severity.INFO
      elseif level == "hint" then
        severity = vim.diagnostic.severity.HINT
      end

      table.insert(diagnostics, {
        lnum = math.max(line - 1, 0),
        col = math.max(col - 1, 0),
        end_lnum = math.max((span.end_line or line) - 1, 0),
        end_col = math.max((span.end_column or col) - 1, 0),
        severity = severity,
        source = "oxlint",
        message = item.message or item.msg or "Oxlint diagnostic",
        code = item.code,
      })
    end
  end

  return diagnostics
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = { enabled = false },
        eslint = { enabled = false },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters.viteplus_oxlint = {
        cmd = "vp",
        stdin = false,
        append_fname = true,
        args = { "exec", "oxlint", "--format", "json" },
        ignore_exitcode = true,
        parser = function(output, bufnr)
          return parse_oxlint(output, bufnr)
        end,
      }

      for _, ft in ipairs(js_filetypes) do
        lint.linters_by_ft[ft] = { "viteplus_oxlint" }
      end

      local group = vim.api.nvim_create_augroup("neoed_viteplus_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = group,
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte", "*.astro" },
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
