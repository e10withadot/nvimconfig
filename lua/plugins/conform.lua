local formatters = {}
local names = vim.api.nvim_get_runtime_file('lua/format/*.lua', true)
for _, abs_name in ipairs(names) do
  local name = vim.fn.fnamemodify(abs_name, ':t:r')
  formatters[name] = require('format.' .. name)
end

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    function(bufnr)
      local disable_filetypes = { razor = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = formatters,
  },
}
