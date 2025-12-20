-- COLORSCHEME --
return {
  -- COLORSCHEME LIST: `:Telescope colorscheme`.
  'EdenEast/nightfox.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('nightfox').setup { specs = {
      carbonfox = {
        diag = {
          warn = '#ffce20',
        },
      },
    } }

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'carbonfox'
  end,
}
