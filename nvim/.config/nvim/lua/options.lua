require "nvchad.options"

-- add yours here!

local opt = vim.opt
local o = vim.o

-- Apariencia
opt.cursorline = true -- Resalta línea actual
opt.cursorlineopt = "both" -- Resalta línea y número
opt.list = false
opt.termguicolors = true -- Colores verdaderos (24-bit)
opt.signcolumn = "yes" -- Siempre muestra columna de signos (evita saltos visuales)
opt.number = true -- Números de línea
opt.relativenumber = true -- Números relativos

-- Scrolling y navegación
opt.scrolloff = 8 -- Mantén 8 líneas arriba/abajo del cursor
opt.sidescrolloff = 8 -- Mantén 8 columnas a los lados
opt.wrap = false -- No hacer wrap de líneas largas
opt.smoothscroll = true -- Scroll suave (Neovim 0.10+)

-- Indentación y formato
opt.expandtab = true -- Usa espacios en lugar de tabs
opt.shiftwidth = 4 -- 4 espacios para indentación (Python standard)
opt.tabstop = 4 -- Tab = 4 espacios
opt.softtabstop = 4 -- 4 espacios al presionar tab
opt.smartindent = true -- Auto-indent inteligente
opt.shiftround = true -- Redondea indent a múltiplo de shiftwidth

-- Búsqueda
opt.ignorecase = true -- Búsqueda case-insensitive
opt.smartcase = true -- Pero case-sensitive si hay mayúsculas
opt.hlsearch = true -- Resalta resultados de búsqueda
opt.incsearch = true -- Búsqueda incremental

-- Splits
opt.splitright = true -- vsplit abre a la derecha
opt.splitbelow = true -- split abre abajo
opt.equalalways = false -- No redimensiona splits automáticamente

-- Backup y archivos
opt.swapfile = false -- No crear swap files
opt.backup = false -- No crear backups
opt.writebackup = false -- No crear backup temporal al escribir
opt.undofile = true -- Historial de undo persistente
opt.undodir = vim.fn.stdpath "data" .. "/undo" -- Directorio para undofiles
opt.undolevels = 10000 -- Más niveles de undo

-- Performance
opt.updatetime = 200 -- Más rápido para CursorHold (default 4000ms)
opt.timeoutlen = 300 -- Tiempo para secuencias de teclas (para which-key)
opt.redrawtime = 10000 -- Más tiempo para operaciones de syntax
opt.synmaxcol = 300 -- Solo syntax highlight hasta columna 300 (performance)

-- Deshabilita providers no usados para mejorar performance
vim.g.loaded_perl_provider = 0 -- Deshabilita provider perl
vim.g.loaded_ruby_provider = 0 -- Deshabilita provider ruby
vim.g.loaded_node_provider = 0 -- Deshabilita provider node (si no lo usas)

-- Comportamiento
opt.mouse = "a" -- Mouse habilitado en todos los modos
opt.clipboard = "unnamedplus" -- Usa clipboard del sistema
opt.completeopt = "menu,menuone,noselect" -- Mejor experiencia de completado
opt.pumheight = 10 -- Altura máxima del popup de completado
opt.showmode = false -- No mostrar modo (ya lo hace lualine/statusline)
opt.conceallevel = 2 -- Oculta markup en markdown/latex (pero muestra al editar)

-- Folding (con Treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- No cerrar folds al abrir archivo
opt.foldlevel = 99

-- Formato de archivos
vim.scriptencoding = "utf-8" -- Encoding del script
vim.opt.encoding = "utf-8" -- Encoding UTF-8
vim.opt.fileformats = "unix,dos,mac" -- Soporta diferentes formatos

-- Wildmenu (completado de comandos)
opt.wildmode = "longest:full,full" -- Completado de comandos
opt.wildignore:append { "*.pyc", "*.pyo", "*/__pycache__/*" } -- Ignora archivos Python compilados
opt.wildignore:append { "*.o", "*.a", "*.so" } -- Ignora binarios
opt.wildignore:append { ".git/*", "node_modules/*", ".venv/*", "venv/*" } -- Ignora directorios comunes

-- Comandos y mensajes
opt.shortmess:append "c" -- No mostrar mensajes de completado
opt.shortmess:append "I" -- No mostrar intro message
opt.showmatch = true -- Resalta paréntesis coincidente

-- Python específico
vim.g.python3_host_prog = vim.fn.exepath "python3" -- Path a Python 3

-- Mejoras de editing
opt.virtualedit = "block" -- Permite cursor en posiciones vacías en modo visual-block
opt.inccommand = "split" -- Muestra preview de sustituciones en split

-- Spell checking (opcional, descomentado si lo quieres)
-- opt.spell = true
-- opt.spelllang = { "es", "en" }
-- opt.spelloptions = "camel" -- Detecta camelCase
