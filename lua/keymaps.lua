-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Ctrl-c> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Put cursor in middle
vim.keymap.set({ 'n', 'v' }, 'k', 'kzz')
vim.keymap.set({ 'n', 'v' }, 'j', 'jzz')
vim.keymap.set({ 'n', 'v' }, 'u', 'uzz')
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, 'G', 'Gzz')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '*', '*zz')
vim.keymap.set({ 'n', 'v', 'ca' }, '<CR>', '<CR>zz')

-- move selected lines
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gvzz")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gvzz")

-- paste and keep
vim.keymap.set('x', '<leader>p', '"_dP')

-- replace word below cursor
vim.keymap.set('n', '<leader>rh', [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>ra', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<leader>e', ':Ex<CR>', { desc = 'Open netrw in current working directory' })

-- Keybinds to make split navigation easier.
--  Use Ctrl+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Open builtin terminal
vim.keymap.set('n', '<leader>t', ':sp | term<CR>', { desc = 'Open terminal split' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybind for one-click run using Makefiles
-- F5 to run "make"
-- F6 to run and debug via "make"
vim.keymap.set('n', '<F5>', '<cmd>sp | term<CR>Amake run<CR>', { desc = 'Run Makefile option' })
vim.keymap.set('n', '<F6>', '<cmd>sp | term<CR>Amake debug<CR>', { desc = 'Run and debug Makefile option' })
