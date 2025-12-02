require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- ============================================
-- MAPPINGS GENERALES
-- ============================================

-- Comandos más rápidos
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Guardar archivo
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quitar highlight de búsqueda
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- Mejor navegación con wrap lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

-- ============================================
-- NAVEGACIÓN ENTRE VENTANAS
-- ============================================

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Redimensionar ventanas
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ============================================
-- NAVEGACIÓN DE BUFFERS Y TABS
-- ============================================

map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- ============================================
-- EDITING MEJORADO
-- ============================================

-- Mover líneas (visual mode)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Mantener selección al indentar
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Pegar sin yanquear en visual mode
map("x", "p", [["_dP]], { desc = "Paste without yank" })

-- Centrar pantalla al navegar búsquedas
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })

-- Mantener cursor en su lugar al hacer J (join lines)
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Copiar al clipboard del sistema
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- ============================================
-- LSP KEYBINDINGS
-- ============================================

map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Diagnósticos
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "[e", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Prev Error" })
map("n", "]e", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Next Error" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix Diagnostics" })

-- Formateo
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file or range" })

-- ============================================
-- TELESCOPE
-- ============================================

map("n", "<leader>fe", function()
  require("telescope").extensions.file_browser.file_browser {
    respect_gitignore = false,
    hidden = true,
  }
end, { desc = "File Browser" })

-- ============================================
-- HARPOON (NAVEGACIÓN RÁPIDA)
-- ============================================

map("n", "<leader>m", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: Mark file" })

map("n", "<leader>o", function()
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon: Open menu" })

map("n", "<leader>j", function()
  require("harpoon"):list():next()
end, { desc = "Harpoon: Next" })

map("n", "<leader>k", function()
  require("harpoon"):list():prev()
end, { desc = "Harpoon: Prev" })

-- Acceso rápido a los primeros 4 archivos de Harpoon
map("n", "<leader>1", function()
  require("harpoon"):list():select(1)
end, { desc = "Harpoon: File 1" })

map("n", "<leader>2", function()
  require("harpoon"):list():select(2)
end, { desc = "Harpoon: File 2" })

map("n", "<leader>3", function()
  require("harpoon"):list():select(3)
end, { desc = "Harpoon: File 3" })

map("n", "<leader>4", function()
  require("harpoon"):list():select(4)
end, { desc = "Harpoon: File 4" })

-- ============================================
-- QUICKFIX Y LOCLIST
-- ============================================

map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "<leader>xc", "<cmd>cclose<cr>", { desc = "Close quickfix" })
map("n", "<leader>xo", "<cmd>copen<cr>", { desc = "Open quickfix" })

-- ============================================
-- PYTHON (RED TEAM / SCRIPTING)
-- ============================================

-- Ejecutar archivo Python actual
map("n", "<leader>pr", "<cmd>!python3 %<cr>", { desc = "Run Python file" })

-- Ejecutar selección en Python
map("v", "<leader>pr", [[:!python3<cr>]], { desc = "Run Python selection" })

-- ============================================
-- TERMINAL TOGGLEABLE
-- ============================================

-- Desactivar mapping por defecto si existe
pcall(vim.keymap.del, "n", "<A-h>")
pcall(vim.keymap.del, "t", "<A-h>")

-- Terminal horizontal (Alt + h) - igual que la flotante
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle horizontal terminal" })

-- Terminal flotante (Alt + i)
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })
