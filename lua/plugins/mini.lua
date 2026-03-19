return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.sessions').setup { autoread = true }
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
