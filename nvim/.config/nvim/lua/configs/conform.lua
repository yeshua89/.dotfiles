local options = {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },

    -- Web Development (SOLO prettierd - el más rápido)
    css = { "prettierd" },
    scss = { "prettierd" },
    less = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    astro = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    graphql = { "prettierd" },

    -- Python (SOLO ruff - todo en uno, ultra rápido)
    python = { "ruff_format", "ruff_organize_imports" },

    -- PHP (solo php-cs-fixer - el mejor)
    php = { "php_cs_fixer" },

    -- Go
    go = { "goimports", "gofumpt" },

    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    -- SQL
    sql = { "sqlfmt" },

    -- TOML
    toml = { "taplo" },
  },

  -- Configuración de formatters individuales
  formatters = {
    -- Python: Ruff (super rápido, reemplaza black + isort + autopep8)
    ruff_format = {
      command = "ruff",
      args = { "format", "--stdin-filename", "$FILENAME", "-" },
    },
    ruff_organize_imports = {
      command = "ruff",
      args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
    },

    -- Shell: shfmt
    shfmt = {
      prepend_args = { "-i", "2", "-ci" }, -- 2 espacios, indent case
    },

    -- Go: gofumpt (más estricto que gofmt)
    gofumpt = {
      prepend_args = { "-extra" },
    },

    -- PHP: php-cs-fixer
    php_cs_fixer = {
      command = "php-cs-fixer",
      args = {
        "fix",
        "$FILENAME",
        "--rules=@PSR12", -- PSR-12 standard
      },
    },

    -- Prettierd (más rápido que prettier)
    prettierd = {
      prepend_args = {
        "--single-quote",
        "--trailing-comma",
        "es5",
        "--print-width",
        "100",
        "--tab-width",
        "2",
      },
    },
  },

  -- Format on save
  format_on_save = function(bufnr)
    -- Deshabilita en archivos grandes
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return
    end

    return {
      timeout_ms = 1000,
      lsp_format = "fallback", -- Usa LSP si no hay formatter configurado
    }
  end,
}

require("conform").setup(options)
