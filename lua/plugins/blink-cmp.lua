return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
  config = function ()
    local blink = require('blink.cmp')
    blink.setup()
    vim.keymap.set('i', '<C-x><C-o>', function ()
      blink.show_and_insert()
    end)
  end
}
