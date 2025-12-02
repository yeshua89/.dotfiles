-- Tu tema personalizado
-- Cambia los colores hexadecimales por los que te gusten
-- Usa esta herramienta para generar variaciones: https://siduck.github.io/hex-tools/

local M = {}

-- ============================================
-- COLORES DE LA INTERFAZ (UI)
-- ============================================
M.base_30 = {
  -- Colores de fondo
  white = "#D9E0EE",           -- Texto principal
  darker_black = "#191828",    -- Fondo más oscuro
  black = "#1E1D2D",           -- Fondo principal de Neovim
  black2 = "#252434",          -- Fondo alternativo 1
  one_bg = "#2d2c3c",          -- Fondo alternativo 2
  one_bg2 = "#363545",         -- Fondo alternativo 3
  one_bg3 = "#3e3d4d",         -- Fondo alternativo 4

  -- Grises
  grey = "#474656",
  grey_fg = "#4e4d5d",
  grey_fg2 = "#555464",
  light_grey = "#605f6f",

  -- Colores de líneas
  line = "#383747",            -- Líneas divisorias (vertsplit)

  -- Colores de acento (CAMBIA ESTOS A TUS FAVORITOS)
  red = "#F38BA8",             -- Rojo (errores, deletes)
  baby_pink = "#ffa5c3",       -- Rosa bebé
  pink = "#F5C2E7",            -- Rosa
  green = "#ABE9B3",           -- Verde (success, adds)
  vibrant_green = "#b6f4be",   -- Verde vibrante
  nord_blue = "#8bc2f0",       -- Azul nord
  blue = "#89B4FA",            -- Azul (funciones, folders)
  yellow = "#FAE3B0",          -- Amarillo (warnings)
  sun = "#ffe9b6",             -- Amarillo sol
  purple = "#d0a9e5",          -- Púrpura (keywords)
  dark_purple = "#c7a0dc",     -- Púrpura oscuro
  teal = "#B5E8E0",            -- Turquesa
  orange = "#F8BD96",          -- Naranja (números)
  cyan = "#89DCEB",            -- Cian (strings)

  -- Colores específicos de UI
  statusline_bg = "#232232",   -- Fondo de statusline
  lightbg = "#2f2e3e",         -- Fondo claro
  pmenu_bg = "#ABE9B3",        -- Fondo del menú popup
  folder_bg = "#89B4FA",       -- Color de carpetas
  lavender = "#c7d1ff",        -- Lavanda
}

-- ============================================
-- COLORES DE SYNTAX HIGHLIGHTING
-- ============================================
M.base_16 = {
  base00 = "#1E1D2D",  -- Fondo principal
  base01 = "#282737",  -- Fondo claro (line numbers)
  base02 = "#2f2e3e",  -- Selection background
  base03 = "#383747",  -- Comentarios, invisibles
  base04 = "#414050",  -- Gutter fg (oscuro)
  base05 = "#bfc6d4",  -- Texto normal
  base06 = "#ccd3e1",  -- Texto claro
  base07 = "#D9E0EE",  -- Texto más claro
  base08 = "#F38BA8",  -- Variables, tags XML, delimiters
  base09 = "#F8BD96",  -- Enteros, booleanos, constantes
  base0A = "#FAE3B0",  -- Clases, tipos
  base0B = "#ABE9B3",  -- Strings, heredoc
  base0C = "#89DCEB",  -- Regex, escape chars
  base0D = "#89B4FA",  -- Funciones, métodos
  base0E = "#CBA6F7",  -- Keywords, storage
  base0F = "#F38BA8",  -- Deprecated, embedded
}

-- ============================================
-- AJUSTES FINOS (Opcional)
-- ============================================
M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.lavender },
    ["@property"] = { fg = M.base_30.teal },
    ["@variable.builtin"] = { fg = M.base_30.red },
  },
}

-- Tipo de tema (dark o light)
M.type = "dark"

-- Aplicar overrides de NvChad
M = require("base46").override_theme(M, "custom")

return M
