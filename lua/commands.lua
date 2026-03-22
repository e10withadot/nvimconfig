-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
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

-- update statusline when new diagnostics appear
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function() vim.schedule(function() vim.cmd.redrawstatus() end) end,
})
