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
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = formatters,
  },
}
