local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
      vim.notify("File saved", vim.log.levels.INFO, { title = "Notification" })
    end,
  })
end

return M
