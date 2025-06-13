return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
      print 'Added file to harpoon!'
    end)
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 9 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
        print('Jumped to ' .. i)
      end)
    end

    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
  end,
}
