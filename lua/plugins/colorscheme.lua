-- COLORSCHEME --
return {
  -- COLORSCHEME LIST: `:Telescope colorscheme`.
  'tiagovla/tokyodark.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyodark').setup {
      transparent_background = true,
    }

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'tokyodark'
  end,
}
