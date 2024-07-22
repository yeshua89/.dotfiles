return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "prettier",
        "pyright",
        "intelephense",
        "black",
        "mypy",
        "ruff",
        "debugpy",
        "bash-language-server",
        "shfmt",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "yaml-language-server",
        "sqlls",
        "phpcbf",
        "eslint_d",
        "gopls",
        "json-lsp",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "sql",
        "python",
        "javascript",
        "typescript",
        "html",
        "go",
        "json",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      auto_install = true,
      indent = { enable = true },
    },
  },
}
