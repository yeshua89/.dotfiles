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

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false,
  --   opts = {
  --     --  Proveedor por defecto.  Cambia esto según el que quieras usar principalmente.
  --     provider = "gemini",
  --
  --     --  Configuración para OpenAI (GPT-4o, GPT-3.5-Turbo, etc.)
  --     openai = {
  --       endpoint = "https://api.openai.com/v1",
  --       model = "gpt-4o", -- Modelo por defecto para OpenAI.  ¡Cambia esto si quieres usar otro!
  --       timeout = 30000,
  --       temperature = 0.7, -- Temperatura un poco más alta para más variedad.  Ajusta según prefieras.
  --       max_tokens = 2048, -- Reduce max_tokens si tienes problemas de costo/límite de tasa.
  --       --  No necesitas 'reasoning_effort' para modelos GPT.
  --       api_key = os.getenv "OPENAI_API_KEY", --  Lee la clave de API desde la variable de entorno.  ¡IMPRESCINDIBLE!
  --     },
  --
  --     -- Configuración para Google Gemini (usando la API de Google AI)
  --     gemini = {
  --       endpoint = "https://generativelanguage.googleapis.com/v1beta/models", -- Endpoint base para Gemini.
  --       model = "gemini-1.5-pro-002", --  ¡Asegúrate de usar el nombre de modelo correcto!  Puede cambiar.
  --       timeout = 30000,
  --       temperature = 0.7,
  --       max_tokens = 2048,
  --       api_key = os.getenv("GEMINI_API_KEY"), --  ¡Necesitas una clave de API de Google AI!
  --     },
  --
  --     -- Configuración para GitHub Copilot (usando el plugin copilot.lua)
  --     copilot = {
  --       --  No necesitas endpoint ni clave de API para Copilot; se configura a través del plugin copilot.lua.
  --       model = "copilot", --  Usa "copilot" como nombre de modelo.
  --       --  No necesitas 'temperature', 'max_tokens' aquí; Copilot lo maneja internamente.
  --       -- asegúrate de tener el plugin `zbirenbaum/copilot.lua` instalado y configurado!
  --       --  Avante se integrará automáticamente con él.
  --       debounce = 250, -- ajusta si es necesario
  --     },
  --
  --     -- Configuración para Anthropic Claude (usando la API de Anthropic)
  --     claude = {
  --       endpoint = "https://api.anthropic.com",
  --       model = "claude-3-opus-20240229", -- ¡Usa el nombre de modelo de Claude correcto! Puede cambiar.
  --       timeout = 30000,
  --       temperature = 0.7,
  --       max_tokens = 2048,
  --       api_key = os.getenv "ANTHROPIC_API_KEY", --  ¡Necesitas una clave de API de Anthropic!
  --       -- Otras opciones de Claude, si las necesitas (consulta la documentación de Anthropic):
  --       -- max_retries = 5,  --  Número máximo de reintentos (si tienes problemas de límite de tasa).
  --     },
  --
  --     -- Configuración del modo dual_boost (opcional y experimental)
  --     dual_boost = {
  --       enabled = false, -- Desactivado por defecto.  Actívalo si quieres probarlo.
  --       first_provider = "openai",
  --       second_provider = "claude",
  --       prompt = "Based on the two reference outputs below, generate a response...", -- Tu prompt.
  --       timeout = 60000,
  --     },
  --
  --     --  Resto de la configuración (comportamiento, mapeos, etc.) -  AJUSTA SEGÚN TUS PREFERENCIAS.
  --     behaviour = {
  --       auto_suggestions = false, --  Sugerencias automáticas (experimental).
  --       auto_set_highlight_group = true,
  --       auto_set_keymaps = true,
  --       auto_apply_diff_after_generation = false,
  --       support_paste_from_clipboard = true, -- Permite pegar desde el portapapeles.
  --       minimize_diff = true,
  --       enable_token_counting = true,
  --       enable_cursor_planning_mode = false,
  --     },
  --     mappings = {
  --       -- Tus mapeos aquí
  --       diff = {
  --         ours = "co",
  --         theirs = "ct",
  --         all_theirs = "ca",
  --         both = "cb",
  --         cursor = "cc",
  --         next = "]x",
  --         prev = "[x",
  --       },
  --       suggestion = {
  --         accept = "<M-l>",
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --         dismiss = "<C-]>",
  --       },
  --       jump = {
  --         next = "]]",
  --         prev = "[[",
  --       },
  --       submit = {
  --         normal = "<CR>",
  --         insert = "<C-s>",
  --       },
  --       sidebar = {
  --         apply_all = "A",
  --         apply_cursor = "a",
  --         switch_windows = "<Tab>",
  --         reverse_switch_windows = "<S-Tab>",
  --       },
  --     },
  --     hints = { enabled = true },
  --     windows = {
  --       position = "right",
  --       wrap = true,
  --       width = 30,
  --       sidebar_header = {
  --         enabled = true,
  --         align = "center",
  --         rounded = true,
  --       },
  --       input = {
  --         prefix = "> ",
  --         height = 8,
  --       },
  --       edit = {
  --         border = "rounded",
  --         start_insert = true,
  --       },
  --       ask = {
  --         floating = false,
  --         start_insert = true,
  --         border = "rounded",
  --         focus_on_apply = "ours",
  --       },
  --     },
  --     highlights = {
  --       -- Tus highlights aquí
  --       diff = {
  --         current = "DiffText",
  --         incoming = "DiffAdd",
  --       },
  --     },
  --     diff = {
  --       autojump = true,
  --       list_opener = "copen",
  --       override_timeoutlen = 500,
  --     },
  --     suggestion = {
  --       debounce = 600,
  --       throttle = 600,
  --     },
  --   },
  --   build = "make",
  --   dependencies = {
  --     --  Tus dependencias (asegúrate de tenerlas todas instaladas).
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "echasnovski/mini.pick",
  --     "nvim-telescope/telescope.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "ibhagwan/fzf-lua",
  --     "nvim-tree/nvim-web-devicons",
  --     "zbirenbaum/copilot.lua", --  ¡Necesario para el proveedor 'copilot'!  Configúralo por separado.
  --     {
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  -- -- Opciones recomendadas de Neovim
  -- vim.opt.laststatus = 3

  {
    "github/copilot.vim",
    event = "InsertEnter", -- Activa Copilot cuando entras en modo inserción
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
