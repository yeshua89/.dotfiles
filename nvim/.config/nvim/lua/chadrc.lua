-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  mason = {
    cmd = true,
    pkgs = {
      -- ======================
      -- Lua
      -- ======================
      "lua-language-server",
      "stylua",

      -- ======================
      -- Web Development
      -- ======================
      "html-lsp",
      "css-lsp",
      "typescript-language-server",
      "prettierd",
      "eslint_d",

      -- Frameworks
      "astro-language-server",
      "tailwindcss-language-server",
      "graphql-language-service-cli",

      -- ======================
      -- Python (Backend/Red Team)
      -- ======================
      "pyright", -- Type checking
      "ruff", -- Linter + Formatter ultra rápido

      -- ======================
      -- PHP
      -- ======================
      "intelephense",
      "php-cs-fixer",

      -- ======================
      -- Go
      -- ======================
      "gopls",
      "gofumpt",
      "goimports",
      "delve", -- Debugger

      -- ======================
      -- Rust
      -- ======================
      "rust-analyzer",

      -- ======================
      -- C/C++
      -- ======================
      "clangd",
      "codelldb",

      -- ======================
      -- Shell/Bash (Red Team)
      -- ======================
      "bash-language-server",
      "shfmt",
      "shellcheck",

      -- ======================
      -- Config files
      -- ======================
      "json-lsp",
      "yaml-language-server",
      "taplo", -- TOML

      -- ======================
      -- Docker & K8s (DevOps)
      -- ======================
      "dockerfile-language-server",
      "docker-compose-language-service",
      "hadolint",
      "helm-ls",

      -- ======================
      -- Database (Backend)
      -- ======================
      "sqlls",
      "sqlfmt",

      -- ======================
      -- Markdown
      -- ======================
      "marksman",
    },
  },
}

M.base46 = {

  theme = "catppuccin",
  transparency = false
}
M.nvdash = { load_on_startup = false }
M.ui = {
  statusline = { theme = "vscode_colored" },

  cmp = {
    style = "flat_dark",
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M
