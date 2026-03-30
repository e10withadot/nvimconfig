vim.pack.add {
    {
        src = 'https://www.github.com/saghen/blink.cmp', -- all-in-one completion engine
        version = vim.version.range('1.x'),
    }
}
-- native completion settings
vim.opt.completeopt = 'menu,fuzzy,noinsert,popup'
vim.opt.shortmess:append 'c'

local blink = require('blink.cmp')
blink.setup {
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
}
