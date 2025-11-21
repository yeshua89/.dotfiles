-- Carga configuración por defecto de NvChad
require("nvchad.configs.lspconfig").defaults()

-- ============================================
-- WEB DEVELOPMENT
-- ============================================

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

-- Typescript/JavaScript (usa ts_ls, el estándar más estable)
vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- ============================================
-- PYTHON (CONFIGURACIÓN AVANZADA)
-- ============================================

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Usamos isort o ruff para esto
    },
    python = {
      analysis = {
        -- Rutas de búsqueda automáticas
        autoSearchPaths = true,
        -- Solo diagnostica archivos abiertos para mejor performance
        diagnosticMode = "openFilesOnly",
        -- Usa código de biblioteca para tipos
        useLibraryCodeForTypes = true,
        -- Type checking mode: "off", "basic", "strict"
        typeCheckingMode = "basic",
        -- Auto import completions
        autoImportCompletions = true,
        -- Diagnostics
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
          reportUnusedVariable = "warning",
          reportUndefinedVariable = "error",
          reportGeneralTypeIssues = "warning",
          reportOptionalMemberAccess = "none",
          reportOptionalSubscript = "none",
          reportPrivateImportUsage = "none",
        },
        -- Stubs
        stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs",
        -- Inlay hints
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          parameterTypes = true,
        },
      },
    },
  },
})

-- Ruff LSP - Ultra rápido linter para Python (el formatter va en conform.lua)
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      lineLength = 88,
      lint = {
        enable = true,
        select = { "E", "F", "I", "UP", "B", "SIM", "C90" },
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false -- pyright hace mejor hover
  end,
})

-- ============================================
-- OTROS LENGUAJES
-- ============================================

-- Lua (para configuración de Neovim)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
})

-- Bash
vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
})

-- PHP
vim.lsp.config("intelephense", {
  filetypes = { "php" },
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
      },
    },
  },
})

-- Rust
vim.lsp.config("rust_analyzer", {
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
})

-- Go
vim.lsp.config("gopls", {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- ============================================
-- FRAMEWORKS & OTROS
-- ============================================

-- Astro
vim.lsp.config("astro", {
  filetypes = { "astro" },
  init_options = {
    typescript = {},
  },
})

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "astro",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

-- Emmet
vim.lsp.config("emmet_language_server", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "astro",
  },
})

-- GraphQL
vim.lsp.config("graphql", {
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
})

-- ============================================
-- CONFIG FILES & DEVOPS
-- ============================================

-- Docker
vim.lsp.config("dockerls", {
  filetypes = { "dockerfile" },
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
})

vim.lsp.config("docker_compose_language_service", {
  filetypes = { "yaml.docker-compose" },
  settings = {
    docker = {
      compose = {
        autoStart = true,
      },
    },
  },
})

-- YAML
vim.lsp.config("yamlls", {
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
        ["https://json.schemastore.org/gitlab-ci"] = ".gitlab-ci.yml",
      },
      format = {
        enable = true,
      },
      validate = true,
      completion = true,
    },
  },
})

-- JSON
vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- TOML
vim.lsp.config("taplo", {
  filetypes = { "toml" },
})

-- SQL
vim.lsp.config("sqlls", {
  filetypes = { "sql", "mysql", "pgsql" },
})

-- ============================================
-- HABILITA TODOS LOS SERVIDORES
-- ============================================

local servers = {
  -- Web básico
  "html",
  "cssls",
  "ts_ls",
  -- Frameworks modernos
  "astro",
  "tailwindcss",
  "emmet_language_server",
  "graphql",
  -- Python (doble LSP: pyright para tipos, ruff para linting)
  "pyright",
  "ruff",
  -- Otros lenguajes
  "lua_ls",
  "bashls",
  "intelephense", -- PHP
  "rust_analyzer",
  "gopls",
  "clangd", -- C/C++
  -- Config/DevOps
  "dockerls",
  "docker_compose_language_service",
  "yamlls",
  "jsonls",
  "taplo", -- TOML
  "sqlls",
  "helm_ls", -- Kubernetes
}

vim.lsp.enable(servers)
