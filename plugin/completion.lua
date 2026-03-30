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
    -- remove all icons
      kind_icons = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Property = '',
        Class = '',
        Interface = '',
        Struct = '',
        Module = '',
        Unit = '',
        Value = '',
        Enum = '',
        EnumMember = '',
        Keyword = '',
        Constant = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
      },
    },
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
}
