return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
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
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
