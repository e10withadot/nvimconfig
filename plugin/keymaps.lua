-- remove keymap timeout
vim.o.timeout = false

-- Put cursor in middle during strong relative jumps
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '*', '*zz')

-- move selected lines
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gvzz")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gvzz")

-- autopairs
vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '{', '{}<Left>')
vim.keymap.set('i', '"', '""<Left>')
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", "`", "``<Left>")

-- paste and keep
vim.keymap.set('x', ' p', '"_dP')

-- easy visual indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- new tab
vim.keymap.set('n', ' t', function ()
 vim.api.nvim_open_tabpage(0, true, {})
end
)

-- replace word below cursor
vim.keymap.set('n', ' rh', [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- replace all instances of word below cursor
vim.keymap.set('n', ' ra', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- undotree
vim.cmd.packadd 'nvim.undotree'
vim.keymap.set('n', ' u', require('undotree').open)

-- toggle quickfix
vim.keymap.set('n', ' l', function ()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.cwindow()
  end
end)
-- next quickfix item
vim.keymap.set('n', ' n', vim.cmd.cnext)
-- previous quickfix item
vim.keymap.set('n', ' N', vim.cmd.cprev)
-- grep for cursor word
vim.keymap.set('n', ' 8', function()
  vim.cmd('silent grep! ' .. vim.fn.expand('<cword>'))
  vim.cmd.cwin()
end)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
