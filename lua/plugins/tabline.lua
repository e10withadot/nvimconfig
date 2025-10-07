return {
  'crispgm/nvim-tabline',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional
  config = function()
    vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeNormal' })
    require('tabline').setup {
      show_index = true,
      show_modify = true,
      show_icon = true,
      fnamemodify = ':t',
      modify_indicator = ' ',
      no_name = 'Undefined',
      brackets = { ' ', ' ' },
      inactive_tab_max_length = 0,
    }
  end,
}
