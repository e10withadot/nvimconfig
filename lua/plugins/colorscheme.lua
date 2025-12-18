-- COLORSCHEME --
return {
  -- COLORSCHEME LIST: `:Telescope colorscheme`.
  'EdenEast/nightfox.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local specs = {
      carbonfox = {
        diag = {
          warn = '#ffce20',
        },
      },
    }
    require('nightfox').setup { specs = specs }

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'carbonfox'
  end,
}
