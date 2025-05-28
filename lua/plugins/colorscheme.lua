-- COLORSCHEME --
return {
  -- COLORSCHEME LIST: `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      styles = {
        comments = { italic = false },
      },
    }

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'tokyonight'
  end,
}
