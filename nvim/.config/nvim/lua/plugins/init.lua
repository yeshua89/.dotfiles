return {
  -- Importa la configuración base de blink.cmp de NvChad
  { import = "nvchad.blink.lazyspec" },

  -- Personalización de blink.cmp
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      local new_opts = vim.tbl_deep_extend("force", opts or {}, {
        keymap = {
          ["<C-n>"] = { "select_next", "fallback" }, -- Siguiente elemento
          ["<C-p>"] = { "select_prev", "fallback" }, -- Elemento anterior
          ["<C-y>"] = { "accept" }, -- Aceptar sugerencia
          ["<C-Space>"] = { "show" }, -- Mostrar menú manualmente
          ["<C-e>"] = { "hide" }, -- Cerrar menú
        },
        completion = {
          documentation = { auto_show = false }, -- Desactiva documentación automática para rapidez
          ghost_text = { enabled = true }, -- Previsualización rápida
        },
        sources = {
          default = { "lsp", "snippets", "buffer", "path" }, -- Fuentes prioritarias
        },
        fuzzy = {
          implementation = "prefer_rust", -- Matcher de Rust para rendimiento
        },
      })
      return new_opts
    end,
  },

  -- Plugins de formateo y LSP
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Plugin de Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },

  -- Plugin de CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = {
      auto_insert_mode = false,
      question_header = "  User ",
      answer_header = "  Copilot ",
      window = {
        width = 0.4,
      },
    },
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      chat.setup(opts)
    end,
  },

  -- Plugin de Treesitter
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

  -- Plugin de Noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
    },
  },

  -- Plugin de Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Plugin de Nvim Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    keys = {
      { "ys", mode = "n" },
      { "ds", mode = "n" },
      { "cs", mode = "n" },
      { "S", mode = "v" },
    },
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- Plugin de Telescope File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "file_browser"
    end,
  },

  -- Plugin de Spectre (buscador/reemplazo avanzado)
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    keys = {
      {
        "<leader>S",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Spectre",
      },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current word",
      },
      {
        "<leader>sp",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
      {
        mode = "v",
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        desc = "Search selection",
      },
    },
    config = function()
      require("spectre").setup {
        is_block_ui_break = true, -- evita glitches en la UI
        default = {
          replace = {
            cmd = "sed", -- puedes cambiar a "oxi" si lo compilas con cargo
          },
        },
      }
    end,
  },
}

