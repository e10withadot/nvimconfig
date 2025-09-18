-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- terminal buffers are hidden, not deleted
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = args.buf })
  end,
})

-- Change tabline color to match statusline on mode change
vim.api.nvim_create_autocmd('ModeChanged', {
  callback = function(mode)
    local newmode = string.match(mode.match, ':(.*)')

    if newmode == 'i' then
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeInsert' })
    elseif newmode == 'v' or newmode == 'V' or newmode == '\22' then
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeVisual' })
    elseif newmode == 'R' then
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeReplace' })
    elseif newmode == 'c' then
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeCommand' })
    elseif newmode == 't' then
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeOther' })
    else
      vim.api.nvim_set_hl(0, 'TabLineSel', { link = 'MiniStatuslineModeNormal' })
    end
  end,
})
