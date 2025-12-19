-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'i'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- Don't show search count or autocompletion warnings
vim.opt.shortmess:append 'S'
vim.opt.shortmess:append 'c'
-- Don't show tabline
vim.o.showtabline = 0

-- netrw settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- remove keymap timeout
vim.o.timeout = false

-- force tab indentation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this oion if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable smart indent
vim.o.smartindent = true

-- Save undo history
vim.o.undofile = true

-- completion
vim.o.completeopt = 'fuzzy,menuone,noinsert'

-- everything unfolded at startup
vim.o.foldenable = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- remove parts of a combined character (nikud)
vim.o.delcombine = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Enable fuzzy finding within directories using :find
vim.opt.path:append '**'
