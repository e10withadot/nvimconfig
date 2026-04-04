-- View neovim packages
vim.api.nvim_create_user_command('Pack', function () vim.pack.update(nil, { offline = true }) end, {})
-- Update neovim packages
vim.api.nvim_create_user_command('PackUpdate', function () vim.pack.update() end, {})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
})

-- session options
vim.opt.sessionoptions = "help,localoptions,resize,winpos,curdir,blank,tabpages,winsize"
-- autosave sessions
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local path = vim.fn.getcwd() .. "/Session.vim"
    if vim.fn.argc() == 0 and vim.fn.filereadable(path) == 1 then
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

-- quickfix closes on enter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
  end,
})

-- the cooler grep
vim.api.nvim_create_user_command('Grep', function(opts)
  if opts.nargs ~= '1' then
    vim.notify('Grep accepts one argument.', vim.log.levels.ERROR, {})
    return
  end
  local word = opts.fargs[1]
  vim.cmd('silent grep! ' .. word)
  vim.cmd.cwin()
end, { nargs = 1 })

-- terminal buffers are hidden, not deleted
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = args.buf })
  end,
})
