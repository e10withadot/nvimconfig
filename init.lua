--[[
    LUA GUIDE: https://learnxinyminutes.com/docs/lua/

    LUA/NEOVIM INTEGRATION:
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

    GENERAL NEOVIM HELP DOCS:
    - :help
    - "<space>sh" ([s]earch the [h]elp documentation
]]
--
local config_dir = vim.fn.stdpath 'config' .. '/lua/'
package.path = config_dir .. '?.lua;' .. package.path

local vimopts = require 'vim-opts'
local keymaps = require 'keymaps'
local autocmd = require 'autocmd'
-- LEADER KEY --
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- SETTINGS OPTIONS --
-- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`
vimopts()

-- KEYMAPS --
--  See `:help vim.keymap.set()`
keymaps()

-- AUTOCOMMANDS --
--  See `:help lua-guide-autocommands`
autocmd()

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- PLUGINS --
require('lazy').setup(
  {
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    { import = 'plugins' },
    -- ADDITIONAL KICKSTART.NVIM PLUGINS --
    --
    -- require 'plugins.optional.debug',
    -- require 'plugins.optional.indent_line',
    -- require 'plugins.optional.lint',
    -- require 'plugins.optional.autopairs',
    -- require 'plugins.optional.neo-tree',
    -- require 'plugins.optional.gitsigns', -- adds gitsigns recommend keymaps
  },

  -- PLUGIN FORMAT HELP: `:help lazy.nvim-🔌-plugin-spec`
  {
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
  }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
