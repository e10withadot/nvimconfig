return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open Oil' })
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
