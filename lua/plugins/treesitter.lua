local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      vim.api.nvim_create_augroup('treesitter.setup', {}),
      callback = function(args)
        local buf = args.buf
        local filetype = args.match

        -- check for valid language
        local lang = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(lang) then
          return
        end

        -- optional treesitter folding
        -- vim.wo.foldmethod = 'expr'
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

        vim.treesitter.start(buf, lang)

        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
