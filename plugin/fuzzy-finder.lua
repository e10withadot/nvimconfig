vim.pack.add {
  'https://www.github.com/ibhagwan/fzf-lua' -- fuzzy finder, uses fzf
}
-- Enable fuzzy finding within directories using :find
vim.opt.path:append '**'

local fzf = require 'fzf-lua'
fzf.register_ui_select()
vim.keymap.set('n', ' sf', fzf.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', ' sw', fzf.grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', ' s8', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', ' sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', ' t', fzf.tabs, { desc = 'Search [T]abs' })
