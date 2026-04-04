-- mouse functionality
vim.o.mouse = 'i'

-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
-- detect tabstop and shiftwidth automatically
vim.pack.add { 'https://www.github.com/tpope/vim-sleuth' }

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable fuzzy finding within directories using :find
vim.opt.path:append '**'

-- enable if terminal supports bidi
vim.o.termbidi = true
-- remove parts of a combined character (nikud)
vim.o.delcombine = true

-- disable swap file
vim.o.swapfile = false

-- native completion settings
vim.opt.complete = '.,w,b,u,o'
vim.opt.completeopt = 'menu,fuzzy,noinsert,popup'
vim.opt.shortmess:append 'c'

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- make sure cshtml is detected
vim.filetype.add {
  extension = {
    cshtml = 'razor',
    razor = 'razor',
  },
}
