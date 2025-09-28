-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

require("nvchad.configs.lspconfig").defaults()

-- HTML y CSSLS con init_options
vim.lsp.config("html", {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

vim.lsp.config("cssls", {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

-- Typescript (sin opciones personalizadas)
vim.lsp.config("ts_ls", {})

-- VTSLS (sin opciones personalizadas)
vim.lsp.config("vtsls", {})

-- Python con settings
vim.lsp.config("pyright", {
  settings = {
    pyright = { "python" }, -- Nota: Verifica si esto es un placeholder; podría ser un error en el original
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- PHP con filetypes
vim.lsp.config("intelephense", {
  filetypes = { "php" },
})

-- Rust con filetypes
vim.lsp.config("rust_analyzer", {
  filetypes = { "rust" },
})

-- Go con filetypes y settings
vim.lsp.config("gopls", {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

-- Docker con filetypes
vim.lsp.config("dockerls", {
  filetypes = { "dockerfile", "yml" },
})

vim.lsp.config("docker_compose_language_service", {
  filetypes = { "yaml.docker-compose" },
})

-- YAML con filetypes
vim.lsp.config("yamlls", {
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
})

-- JSON con filetypes
vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
})

-- Habilita todos los servidores
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "vtsls",
  "pyright",
  "intelephense",
  "rust_analyzer",
  "gopls",
  "dockerls",
  "docker_compose_language_service",
  "yamlls",
  "jsonls",
}
vim.lsp.enable(servers)
