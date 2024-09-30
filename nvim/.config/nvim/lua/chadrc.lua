-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  mason = {
    cmd = true,
    pkgs = {
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
      "vtsls",
    },
  },
}

M.ui = {
  theme = "chadracula-evondev",
  transparency = true,

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M
