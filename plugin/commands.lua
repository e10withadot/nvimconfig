-- View neovim packages
vim.api.nvim_create_user_command('Pack', function () vim.pack.update(nil, { offline = true }) end, {})
-- Update neovim packages
vim.api.nvim_create_user_command('PackUpdate', function () vim.pack.update() end, {})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
})

-- session options
vim.opt.sessionoptions = "help,options,resize,winpos,curdir,blank,tabpages,winsize"
-- autosave sessions
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local path = vim.fn.getcwd() .. "/Session.vim"
    if vim.fn.argc() == 0 and #vim.api.nvim_list_tabpages() > 0 then
      vim.cmd('mksession! ' .. path)
    end
  end,
  nested = true,
})
-- autoload sessions
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.getcwd() .. "/Session.vim"
    if vim.fn.argc() == 0 and vim.fn.filereadable(path) == 1 then
      vim.api.nvim_buf_set_name(0, '')
      vim.cmd("silent! source " .. path)
      vim.defer_fn(function()
        vim.cmd("silent! filetype detect")
        vim.cmd("syntax on | redraw")
      end, 100)
    end
  end,
  nested = true,
})

-- terminal buffers are hidden, not deleted
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = args.buf })
  end,
})
