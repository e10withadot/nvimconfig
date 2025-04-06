return function()
  -- DIAGNOSTIC CONFIG --
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = {},
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      severity = vim.diagnostic.severity.ERROR,
    },
  }
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = vim.api.nvim_create_augroup('float_diagnostic_cursor', { clear = true }),
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
    end,
  })
end
