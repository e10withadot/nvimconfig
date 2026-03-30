vim.pack.add {
  {
    src = 'https://www.github.com/nvim-treesitter/nvim-treesitter', -- treesitter parse repo
    version = 'main'
  }
}
local ts = require('nvim-treesitter')

local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
ts.install(ensure_installed)

local treesitter_start = function(buf)
  pcall(vim.treesitter.start)
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local treesitter_install = function(buf, lang)
  -- check if parser is available
  local get_available = ts.get_available()
  for _, l in ipairs(get_available) do
    if l == lang then
      -- install parser
      ts.install(lang):await(function()
        treesitter_start(buf)
      end)
      -- check again
      if not vim.treesitter.start() then
        return
      end
    end
  end
end

-- when nvim-treesitter updates
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function (ev)
    local name, kind = ev.data.spec.name, ev.data.spec.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      ts.update()
    end
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter.setup', {}),
  callback = function(event)
    local filetype = event.match
    local lang = vim.treesitter.language.get_lang(filetype) or filetype
    if not vim.treesitter.language.add(lang) then
      treesitter_install(event.buf, lang)
    end
    treesitter_start(event.buf)
  end,
})

vim.api.nvim_create_user_command('TSStart', function()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo.filetype
  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  if lang then
    treesitter_start(buf)
  else
    vim.notify('Language not available.', vim.log.levels.ERROR, {})
  end
end, {})
