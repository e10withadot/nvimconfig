return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  config = function()
    local oil = require('oil')
    oil.setup {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', oil.open, { desc = 'Open Oil' })
    vim.keymap.set('n', '_', function ()
      vim.cmd.tabnew()
      oil.open()
    end, { desc = 'Open Oil in new tab' })
  end,
}
