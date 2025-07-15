require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nuevos atajos para los plugins
map("n", "<leader>m", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: Marcar archivo" })

map("n", "<leader>o", function()
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon: Abrir menu" })

map("n", "<leader>j", function()
  require("harpoon"):list():next()
end, { desc = "Harpoon: Siguiente en la lista" })

map("n", "<leader>k", function()
  require("harpoon"):list():prev()
end, { desc = "Harpoon: Anterior en la lista" })

map("n", "<leader>fe", function()
  require("telescope").extensions.file_browser.file_browser({
    respect_gitignore = false,
    hidden = true,
  })
end, { desc = "Telescope: Explorador de archivos" })
