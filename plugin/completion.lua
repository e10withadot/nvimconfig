vim.pack.add {
    {
        src = 'https://www.github.com/saghen/blink.cmp', -- all-in-one completion engine
        version = vim.version.range('1.0.0 - 2.0.0'),
    }
}
-- Don't show autocompletion warnings
vim.opt.shortmess:append 'c'

local blink = require('blink.cmp')
blink.setup {
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
}
vim.keymap.set('i', '<C-x><C-o>', blink.show_and_insert)
