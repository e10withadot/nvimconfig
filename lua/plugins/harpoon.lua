return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon.setup {}
    -- keymaps
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon menu' })
    vim.keymap.set('n', '<leader>pa', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })
    vim.keymap.set('n', '<leader>pr', function()
      harpoon:list():remove()
    end, { desc = 'Remove file from harpoon' })
    vim.keymap.set('n', '<A-1>', function()
      harpoon:list():select(1)
    end, { desc = 'Open harpoon tab 1' })
    vim.keymap.set('n', '<A-2>', function()
      harpoon:list():select(2)
    end, { desc = 'Open harpoon tab 2' })
    vim.keymap.set('n', '<A-3>', function()
      harpoon:list():select(3)
    end, { desc = 'Open harpoon tab 3' })
    vim.keymap.set('n', '<A-4>', function()
      harpoon:list():select(4)
    end, { desc = 'Open harpoon tab 4' })
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<A-p>', function()
      harpoon:list():prev()
    end, { desc = 'Select previous harpoon file' })
    vim.keymap.set('n', '<A-n>', function()
      harpoon:list():next()
    end, { desc = 'Select next harpoon file' })
  end,
}
