return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  -- or if using mini.icons/mini.nvim
  dependencies = {
    'nvim-mini/mini.nvim',
  },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {},
  ---@diagnostics enable: missing-fields
  config = function()
    local fzf = require 'fzf-lua'
    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', fzf.git_files, { desc = '[S]earch [G]it' })
    vim.keymap.set('n', '<leader>sw', fzf.grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>s8', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>ss', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>t', fzf.tabs, { desc = 'Search [T]abs' })
  end,
}
