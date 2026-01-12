-- Tu tema personalizado
-- Cambia los colores hexadecimales por los que te gusten
-- Usa esta herramienta para generar variaciones: https://siduck.github.io/hex-tools/

local M = {}

-- ============================================
-- COLORES DE LA INTERFAZ (UI)
-- Combinación Catppuccin Mocha + Rose Pine Dark
-- ============================================
M.base_30 = {
  -- Colores de fondo (muy oscuros para cuidar la vista)
  white = "#e0def4",           -- Texto principal (Rose Pine)
  darker_black = "#0f0e17",    -- Fondo más oscuro (Catppuccin Crust más oscuro)
  black = "#11111b",           -- Fondo principal (Catppuccin Crust)
  black2 = "#181825",          -- Fondo alternativo 1 (Catppuccin Mantle)
  one_bg = "#1e1e2e",          -- Fondo alternativo 2 (Catppuccin Base)
  one_bg2 = "#232136",         -- Fondo alternativo 3 (Rose Pine Base)
  one_bg3 = "#2a273f",         -- Fondo alternativo 4 (Rose Pine Surface)

  -- Grises (suaves y apagados)
  grey = "#393552",            -- Rose Pine Overlay
  grey_fg = "#44415a",         -- Rose Pine Highlight Med
  grey_fg2 = "#56526e",        -- Rose Pine Highlight High
  light_grey = "#6e6a86",      -- Rose Pine Muted
  delimiter = "#b8b8b8",       -- Gris claro para . : , (bien visible)

  -- Colores de líneas
  line = "#313244",            -- Líneas divisorias (Catppuccin Surface0)

  -- Colores de acento (combinación armoniosa)
  red = "#eb6f92",             -- Rojo (Rose Pine Love)
  baby_pink = "#ea9a97",       -- Rosa bebé (Rose Pine Rose)
  pink = "#f5c2e7",            -- Rosa (Catppuccin Pink)
  green = "#a6e3a1",           -- Verde (Catppuccin Green)
  vibrant_green = "#9ccfd8",   -- Verde vibrante (Rose Pine Foam)
  nord_blue = "#74c7ec",       -- Azul nord (Catppuccin Sapphire)
  blue = "#89b4fa",            -- Azul (Catppuccin Blue)
  yellow = "#f6c177",          -- Amarillo (Rose Pine Gold)
  sun = "#f9e2af",             -- Amarillo sol (Catppuccin Yellow)
  purple = "#c4a7e7",          -- Púrpura (Rose Pine Iris)
  dark_purple = "#cba6f7",     -- Púrpura oscuro (Catppuccin Mauve)
  teal = "#94e2d5",            -- Turquesa (Catppuccin Teal)
  orange = "#fab387",          -- Naranja (Catppuccin Peach)
  cyan = "#89dceb",            -- Cian (Catppuccin Sky)

  -- Colores específicos de UI
  statusline_bg = "#11111b",   -- Fondo de statusline (muy oscuro)
  lightbg = "#232136",         -- Fondo claro (Rose Pine Base)
  pmenu_bg = "#3e8fb0",        -- Fondo del menú popup (Rose Pine Pine)
  folder_bg = "#89b4fa",       -- Color de carpetas (Catppuccin Blue)
  lavender = "#b4befe",        -- Lavanda (Catppuccin Lavender)
}

-- ============================================
-- COLORES DE SYNTAX HIGHLIGHTING
-- ============================================
M.base_16 = {
  base00 = "#11111b",  -- Fondo principal (Catppuccin Crust - muy oscuro)
  base01 = "#181825",  -- Fondo claro (line numbers - Catppuccin Mantle)
  base02 = "#1e1e2e",  -- Selection background (Catppuccin Base)
  base03 = "#6e6a86",  -- Comentarios, invisibles (Rose Pine Muted)
  base04 = "#908caa",  -- Gutter fg (Rose Pine Subtle)
  base05 = "#e0def4",  -- Texto normal (Rose Pine Text)
  base06 = "#f0ecfe",  -- Texto claro
  base07 = "#f5f3ff",  -- Texto más claro
  base08 = "#eb6f92",  -- Variables, tags XML, delimiters (Rose Pine Love)
  base09 = "#fab387",  -- Enteros, booleanos, constantes (Catppuccin Peach)
  base0A = "#f6c177",  -- Clases, tipos (Rose Pine Gold)
  base0B = "#a6e3a1",  -- Strings, heredoc (Catppuccin Green)
  base0C = "#9ccfd8",  -- Regex, escape chars (Rose Pine Foam)
  base0D = "#89b4fa",  -- Funciones, métodos (Catppuccin Blue)
  base0E = "#c4a7e7",  -- Keywords, storage (Rose Pine Iris)
  base0F = "#ea9a97",  -- Deprecated, embedded (Rose Pine Rose)
}

-- ============================================
-- AJUSTES FINOS - Sintaxis bien diferenciada
-- ============================================
M.polish_hl = {
  treesitter = {
    -- KEYWORDS y CONTROL (def, class, if, return, import, etc) - Púrpura
    ["@keyword"] = { fg = M.base_30.purple, bold = true },
    ["@keyword.function"] = { fg = M.base_30.purple, bold = true },      -- def
    ["@keyword.operator"] = { fg = M.base_30.purple },                   -- and, or, not
    ["@keyword.return"] = { fg = M.base_30.dark_purple, bold = true },   -- return
    ["@keyword.import"] = { fg = M.base_30.purple, italic = true },      -- import, from
    ["@conditional"] = { fg = M.base_30.purple, bold = true },           -- if, else, elif
    ["@repeat"] = { fg = M.base_30.purple, bold = true },                -- for, while

    -- CLASES y TIPOS - Amarillo/Dorado brillante
    ["@type"] = { fg = M.base_30.yellow, bold = true },
    ["@type.builtin"] = { fg = M.base_30.sun, bold = true },             -- int, str, bool
    ["@type.definition"] = { fg = M.base_30.yellow, bold = true },       -- class Name
    ["@constructor"] = { fg = M.base_30.yellow },                         -- Book(...)

    -- FUNCIONES y MÉTODOS - Azul brillante
    ["@function"] = { fg = M.base_30.blue, bold = true },
    ["@function.call"] = { fg = M.base_30.blue },                        -- llamadas a funciones
    ["@function.builtin"] = { fg = M.base_30.nord_blue, bold = true },  -- print, len, range
    ["@method"] = { fg = M.base_30.blue },
    ["@method.call"] = { fg = M.base_30.blue },

    -- VARIABLES - Lavanda suave (variables normales)
    ["@variable"] = { fg = M.base_30.lavender },
    ["@variable.member"] = { fg = M.base_30.teal },                      -- objeto.atributo

    -- PROPIEDADES y ATRIBUTOS - Teal/Cyan distintivo
    ["@property"] = { fg = M.base_30.teal, italic = true },              -- self.id_book
    ["@field"] = { fg = M.base_30.teal },
    ["@attribute"] = { fg = M.base_30.cyan },                            -- decoradores @

    -- PARÁMETROS - Color rosado suave
    ["@parameter"] = { fg = M.base_30.baby_pink, italic = true },        -- (self, id_book, author)
    ["@variable.parameter"] = { fg = M.base_30.baby_pink, italic = true },

    -- VARIABLES ESPECIALES - Rojo distintivo
    ["@variable.builtin"] = { fg = M.base_30.red, bold = true },         -- self, cls
    ["@constant.builtin"] = { fg = M.base_30.red, bold = true },         -- True, False, None

    -- CONSTANTES - Naranja intenso
    ["@constant"] = { fg = M.base_30.orange, bold = true },              -- CONSTANTES_MAYUSCULAS
    ["@number"] = { fg = M.base_30.orange },
    ["@number.float"] = { fg = M.base_30.orange },
    ["@boolean"] = { fg = M.base_30.red, bold = true },                  -- True, False

    -- STRINGS - Verde brillante
    ["@string"] = { fg = M.base_30.green },
    ["@string.documentation"] = { fg = M.base_30.green, italic = true }, -- docstrings
    ["@string.escape"] = { fg = M.base_30.vibrant_green, bold = true }, -- \n, \t
    ["@string.special"] = { fg = M.base_30.vibrant_green },              -- f-strings
    ["@character"] = { fg = M.base_30.green },

    -- OPERADORES - Color distintivo
    ["@operator"] = { fg = M.base_30.cyan },                             -- +, -, =, ==
    ["@punctuation.bracket"] = { fg = M.base_30.white },                 -- (), [], {}
    ["@punctuation.delimiter"] = { fg = M.base_30.delimiter, bold = true },  -- , . : (MUY VISIBLES)

    -- COMENTARIOS - Gris suave
    ["@comment"] = { fg = M.base_30.grey_fg2, italic = true },
    ["@comment.documentation"] = { fg = M.base_30.light_grey, italic = true },

    -- OTROS
    ["@namespace"] = { fg = M.base_30.yellow },                          -- módulos
    ["@label"] = { fg = M.base_30.pink },                                -- labels
    ["@tag"] = { fg = M.base_30.red },                                   -- HTML/XML tags
    ["@tag.attribute"] = { fg = M.base_30.teal },
    ["@tag.delimiter"] = { fg = M.base_30.grey_fg },
  },
}

-- Tipo de tema (dark o light)
M.type = "dark"

-- Aplicar overrides de NvChad
M = require("base46").override_theme(M, "mytheme")

return M
