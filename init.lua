local config_dir = vim.fn.stdpath 'config' .. '/lua/'
package.path = config_dir .. '?.lua;' .. package.path

local vimopts = require 'vim-opts'
local keymaps = require 'keymaps'
local autocmd = require 'autocmd'

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- call vim options, generic keymaps, and autocommands
vimopts()
keymaps()
autocmd()

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Plugin import
require('lazy').setup({
  { import = 'plugins' },
  -- ADDITIONAL KICKSTART.NVIM PLUGINS --
  --
  -- require 'plugins.optional.debug',
  -- require 'plugins.optional.indent_line',
  -- require 'plugins.optional.lint',
  -- require 'plugins.optional.autopairs',
  -- require 'plugins.optional.neo-tree',
  -- require 'plugins.optional.gitsigns', -- adds gitsigns recommend keymaps
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`.
-- vim: ts=2 sts=2 sw=2 et
