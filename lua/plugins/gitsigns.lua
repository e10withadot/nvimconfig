return {
  -- See `:help gitsigns` to understand what the configuration keys do
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      -- set colors before calling setup
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = 'green' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = 'yellow' })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = 'red' })
      require('gitsigns').setup()
    end,
  },
}
