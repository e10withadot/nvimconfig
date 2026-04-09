vim.pack.add {
  'https://github.com/romus204/tree-sitter-manager.nvim', -- treesitter parser repo
}

require("tree-sitter-manager").setup {
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
}
