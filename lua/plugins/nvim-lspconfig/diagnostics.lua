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
  -- show error on Q
  vim.keymap.set('n', 'Q', function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
  end, { desc = 'Show diagnostic float at cursor' })
end
