-- PHP/WordPress/Laravel Configuration
-- Formatter selection is dynamic based on project type:
--   WordPress (wp-config.php, phpcs.xml) → phpcbf
--   Laravel (artisan, pint.json) → pint
--   Other PHP → php-cs-fixer
--
-- Detection happens lazily at format-time, not on startup

vim.g.lazyvim_php_lsp = "intelephense"

local lsp = vim.g.lazyvim_php_lsp or "intelephense"

--- Detect project type based on root markers (cached per directory)
--- @param bufnr number
--- @return "wordpress"|"laravel"|"php"
local function detect_php_project(bufnr)
  local root_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")

  -- Cache detection result per root directory
  vim.g._php_project_cache = vim.g._php_project_cache or {}
  if vim.g._php_project_cache[root_dir] then
    return vim.g._php_project_cache[root_dir]
  end

  local function find_upward(patterns)
    return vim.fs.find(patterns, {
      path = root_dir,
      upward = true,
      stop = vim.env.HOME,
      type = "file",
    })[1]
  end

  local function find_upward_dir(patterns)
    return vim.fs.find(patterns, {
      path = root_dir,
      upward = true,
      stop = vim.env.HOME,
      type = "directory",
    })[1]
  end

  local project_type = "php" -- default

  -- WordPress detection: wp-config.php, wp-content/, or phpcs.xml with WP rules
  if find_upward({ "wp-config.php", "wp-config-sample.php" }) or find_upward_dir({ "wp-content", "wp-includes" }) then
    project_type = "wordpress"
  -- Check for phpcs.xml that might indicate WordPress standards
  elseif find_upward({ "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" }) then
    local phpcs_file = find_upward({ "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" })
    if phpcs_file then
      local content = vim.fn.readfile(phpcs_file, "", 50) -- Read first 50 lines
      local content_str = table.concat(content, "\n"):lower()
      if content_str:find("wordpress") or content_str:find("wpcs") then
        project_type = "wordpress"
      end
    end
  -- Laravel detection: artisan file or pint.json
  elseif find_upward({ "artisan", "pint.json" }) then
    project_type = "laravel"
  end

  vim.g._php_project_cache[root_dir] = project_type
  return project_type
end

--- Get formatters for PHP based on detected project type
--- @param bufnr number
--- @return table
local function get_php_formatters(bufnr)
  local project = detect_php_project(bufnr)

  if project == "wordpress" then
    -- WordPress: phpcbf uses phpcs.xml from project root
    return { "phpcbf" }
  elseif project == "laravel" then
    -- Laravel: pint with php-cs-fixer fallback
    return { "pint", "php_cs_fixer", stop_after_first = true }
  else
    -- Generic PHP: php-cs-fixer
    return { "php_cs_fixer" }
  end
end

return {
  -- Treesitter parsers for PHP/Blade
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "php",
        "php_only",
        "blade",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          enabled = lsp == "intelephense",
          filetypes = { "php", "blade", "php_only" },
          settings = {
            intelephense = {
              files = {
                associations = { "*.php", "*.blade.php" },
                maxSize = 5000000,
              },
              -- WordPress/Laravel stubs for better completions
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "Core",
                "curl",
                "date",
                "dom",
                "fileinfo",
                "filter",
                "gd",
                "hash",
                "iconv",
                "intl",
                "json",
                "libxml",
                "mbstring",
                "meta",
                "mysqli",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "Reflection",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "standard",
                "superglobals",
                "tokenizer",
                "xml",
                "xmlreader",
                "xmlwriter",
                "yaml",
                "zip",
                "zlib",
                "wordpress", -- WordPress stubs
              },
            },
          },
        },
        [lsp] = {
          enabled = true,
        },
      },
    },
  },

  -- Mason: Install formatters/tools on demand
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "blade-formatter",
        "php-cs-fixer",
        "php-debug-adapter",
        "phpcbf", -- WordPress formatter
        "phpcs", -- WordPress linter (phpcbf dependency)
        "phpstan",
        "pint",
      },
    },
  },

  -- Formatting: Dynamic formatter selection based on project type
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      -- PHP: Dynamic formatter based on project type (WordPress/Laravel/Generic)
      opts.formatters_by_ft.php = get_php_formatters

      -- Blade: Always use blade-formatter
      opts.formatters_by_ft.blade = { "blade-formatter" }

      -- Configure formatters
      opts.formatters["blade-formatter"] = {
        prepend_args = { "--indent-size=2", "--wrap-attributes=auto" },
      }

      -- phpcbf: Uses phpcs.xml from project root automatically
      opts.formatters.phpcbf = {
        -- Only run if phpcs.xml exists (WordPress projects should have this)
        condition = function(_, ctx)
          return vim.fs.find(
            { "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" },
            { path = ctx.dirname, upward = true, stop = vim.env.HOME }
          )[1] ~= nil
        end,
      }

      return opts
    end,
  },

  -- DAP: PHP debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local path = vim.fn.expand("$MASON/packages/php-debug-adapter")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },
}
