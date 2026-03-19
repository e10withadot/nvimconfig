-- functions
local comp = {}

-- global statusline func
function _G.status(func)
  return comp[func]();
end

-- tab number
function comp.tabnr()
  if vim.fn.tabpagenr '$' ~= 1 then
    return ' 󰓩 ' .. vim.fn.tabpagenr()
  else
    return ''
  end
end

-- search count
function comp.search()
  if not vim.v.hlsearch then return '' end

  local ok, count = pcall(vim.fn.searchcount, { maxcount = 9999 })
  if not ok then return ' ?/? ' end
  if count.total == 0 or count.current == 0 then
    return ''
  elseif count.incomplete == 1 then
    return ' ' .. count.current .. '/? '
  else
    return ' ' .. count.current .. '/' .. count.total .. ' '
  end
end

-- error count
function comp.diagnostic_count()
  local counts = {
    err = 0,
    warn = 0,
    info = 0,
    hint = 0,
  }
  local dia_table = vim.diagnostic.get(0)
  for _, msg in ipairs(dia_table) do
    if msg.severity == vim.diagnostic.severity.ERROR then
      counts.err = counts.err + 1
    elseif msg.severity == vim.diagnostic.severity.WARN then
      counts.warn = counts.warn + 1
    elseif msg.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    elseif msg.severity == vim.diagnostic.severity.HINT then
      counts.hint = counts.hint + 1
    end
  end
  local output = ''
  if counts.err > 0 then
    output = output .. ' 󰅚 ' .. tostring(counts.err)
  end
  if counts.warn > 0 then
    output = output .. ' 󰀪 ' .. tostring(counts.warn)
  end
  if counts.info > 0 then
    output = output .. ' 󰋽 ' .. tostring(counts.info)
  end
  if counts.hint > 0 then
    output = output .. ' 󰌶 ' .. tostring(counts.hint)
  end
  return output
end

-- highlights
vim.api.nvim_set_hl(0, 'StatusPrimary', { fg = '#DDDDDD', bg = '#333333' })
vim.api.nvim_set_hl(0, 'StatusSecondary', { fg = '#333333', bg = '#DDDDDD', bold = true })
vim.api.nvim_set_hl(0, 'StatusGit', { fg = '#DDDDDD', bg = '#444444' })

local mode = '%#StatusSecondary# %{toupper(mode())} %*'
local gitinfo = "%#StatusGit#  %{get(b:,'gitsigns_head','')} %*"
local tabinfo = '%#StatusPrimary#%{v:lua.status("tabnr")}'
local fileinfo = ' %q%F%m%r'
local diagnostics = ' %{v:lua.status("diagnostic_count")}'
local searchcount = '%{v:lua.status("search")}'
local filetype = '%{&fileformat} | %{&filetype} %*'
local rowcol = '%#StatusSecondary# %l,%c '

vim.o.statusline = mode .. gitinfo .. tabinfo .. fileinfo .. diagnostics .. ' %= ' .. searchcount .. filetype .. rowcol
