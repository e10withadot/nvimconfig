return {
  -- See `:help gitsigns` to understand what the configuration keys do
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function()
      -- set colors before calling setup
      vim.cmd [[ highlight GitSignsAdd guifg=green ]]
      vim.cmd [[ highlight GitSignsChange guifg=yellow ]]
      vim.cmd [[ highlight GitSignsDelete guifg=red ]]
      require('gitsigns').setup()
    end,
  },
}
