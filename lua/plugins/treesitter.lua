local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

local treesitter_start = function(buf, lang)
  -- highlighting
  pcall(vim.treesitter.start, buf, lang)

  -- folding
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldenable = false

  -- indentation
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local treesitter_install = function(buf, lang)
  local ts = require 'nvim-treesitter'
  -- check if parser is available
  local get_available = ts.get_available()
  for _, l in ipairs(get_available) do
    if l == lang then
      -- install parser
      ts.install(lang):await(function()
        treesitter_start(buf, lang)
      end)
      -- check again
      if not vim.treesitter.language.add(lang) then
        return
      end
    end
  end
end

return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter.setup', {}),
      callback = function(event)
        local filetype = event.match
        local lang = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(lang) then
          treesitter_install(event.buf, lang)
        end
        treesitter_start(event.buf, lang)
      end,
    })
  end,
}
