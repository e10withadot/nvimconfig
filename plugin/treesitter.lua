-- when nvim-treesitter updates
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function (ev)
    local name, kind = ev.data.spec.name, ev.data.spec.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add {
  {
    src = 'https://www.github.com/nvim-treesitter/nvim-treesitter', -- treesitter parser repo
    version = 'main'
  }
}
local ts = require('nvim-treesitter')

local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
ts.install(ensure_installed)

local treesitter_install = function(buf, lang)
  local installed = ts.get_installed()
  if not vim.list_contains(installed, lang) then
    local ok, err = pcall(ts.install, lang)
    if not ok then
      vim.notify('Failed to install parser: ' .. lang .. ' - ' .. tostring(err), vim.log.levels.ERROR)
      return
    end
  end
  pcall(vim.treesitter.start, buf, lang)
end

-- automatically install and start treesitter
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter.setup', {}),
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(event.match) or event.match
    local available = ts.get_available()
    if not vim.list_contains(available, lang) then return end
    if not vim.treesitter.language.add(lang) then
      treesitter_install(event.buf, lang)
    end
    pcall(vim.treesitter.start, event.buf, lang)
  end,
})

vim.api.nvim_create_user_command('TSStart', function()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo.filetype
  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  if lang then
    pcall(vim.treesitter.start, buf, lang)
  else
    vim.notify('Language not available.', vim.log.levels.WARN, {})
  end
end, {})
