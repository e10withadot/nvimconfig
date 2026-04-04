vim.pack.add {
    'https://www.github.com/stevearc/oil.nvim' -- cool file browser
}
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local oil = require('oil')
oil.setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  columns = {
    "permissions",
    "size",
    "mtime",
  },
}
vim.keymap.set('n', '-', oil.open, { desc = 'Open Oil' })
