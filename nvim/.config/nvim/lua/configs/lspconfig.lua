-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- python
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pyright = { "python" },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- php
lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "php" },
}

-- rust
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
}

-- go
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
}

-- docker
lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "dockerfile", "yml" },
}

lspconfig.docker_compose_language_service.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml.docker-compose" },
}

-- yml
lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
}

-- json
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "json", "jsonc" },
}
