-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- session management
-- load session on startup if exists
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.filereadable("Session.vim") == 1 then
      vim.cmd("source Session.vim")
      vim.cmd("silent! filetype detect")
    end
  end,
})

-- save session on leave if exists
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function ()
    if vim.fn.filereadable("Session.vim") == 1 then
      vim.cmd('mksession! Session.vim')
    end
  end,
})

-- terminal buffers are hidden, not deleted
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = args.buf })
  end,
})

-- Toggle between hebrew and english
vim.api.nvim_create_user_command('HebrewToggle', function()
  if not vim.b.hebrew_mode then
    vim.opt_local.keymap = 'hebrew'
    vim.opt_local.iminsert = 1
    vim.opt_local.imsearch = 1
    vim.b.hebrew_mode = true
    vim.notify 'Switched to Hebrew'
  else
    vim.opt_local.keymap = 'english'
    vim.opt_local.iminsert = 0
    vim.opt_local.imsearch = 0
    vim.notify 'Switched to English'
  end
end, {})
