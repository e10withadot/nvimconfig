-- Don't show mode
vim.o.showmode = false
-- Don't show search count
vim.opt.shortmess:append 'S'
-- Don't show tabline
vim.o.showtabline = 0

-- functions
local comp = {}

-- global statusline func
function _G.status(func)
  return comp[func]()
end

-- tab number
function comp.tabnr()
  if vim.fn.tabpagenr '$' ~= 1 then
    return '  #' .. vim.fn.tabpagenr()
  else
    return ''
  end
end

-- git branch info
function comp.git_branch()
  local fname = vim.api.nvim_buf_get_name(0)
  local filetype = vim.filetype.match({ buf = 0 })
  if fname == '' or filetype == nil then return '' end
  local dir = vim.fn.fnamemodify(fname, ":p:h")

  if vim.fn.has("win32") == 1 then
    dir = vim.fn.substitute(dir, "/", "\\", "g")
  end
  if filetype == 'oil' then
    dir = dir:match('^oil://(.*)')
  end
  if vim.fn.isdirectory(dir) == 0 then
    return ''
  end

  local res = vim.system({ "git", "branch", "--show-current" }, { cwd = dir, text = true }):wait()
  if res.code ~= 0 then return '' end
  local branch = res.stdout:gsub("%s+", "")
  return ' ' .. branch .. ' '
end

-- search count
function comp.search()
  if vim.fn.eval('v:hlsearch') == 0 then return '' end

  local ok, count = pcall(vim.fn.searchcount, { maxcount = 9999 })
  if not ok then return '?/?' end

  local total   = count.total   or 0
  local current = count.current or 0
  local incomplete = count.incomplete or 0

  if total == 0 or current == 0 then
    return ''
  elseif incomplete == 1 then
    return current .. '/?'
  else
    return current .. '/' .. total
  end
end

local counts = {}

-- error count
local diagnostic_count = function()
  counts = {
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
  return counts
end

function comp.errors()
  diagnostic_count()
  if counts.err > 0 then
    return ' E' .. tostring(counts.err) .. ' '
  end
  return ''
end

function comp.warnings()
  if counts.warn > 0 then
    return ' W' .. tostring(counts.warn) .. ' '
  end
  return ''
end

function comp.info()
  if counts.info > 0 then
    return ' I' .. tostring(counts.info) .. ' '
  end
  return ''
end

function comp.hints()
  if counts.hint > 0 then
    return ' H' .. tostring(counts.hint) .. ' '
  end
  return ''
end

-- highlights
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#DDDDDD', bg = '#333333' })
vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#DDDDDD', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineGit', { fg = '#DDDDDD', bg = '#444444' })


local mode = '%#StatusLineMode# %{mode()} %*'
local gitinfo = '%#StatusLineGit#%{v:lua.status("git_branch")}%*'
local tabinfo = '%{v:lua.status("tabnr")}'
local fileinfo = ' %q%F%m%r'
local diagnostics = ' %#DiagnosticError#%{v:lua.status("errors")}%*%#DiagnosticWarn#%{v:lua.status("warnings")}%*%#DiagnosticInfo#%{v:lua.status("info")}%*%#DiagnosticHint#%{v:lua.status("hints")}%*'
local searchcount = '%{v:lua.status("search")} '
local filetype = '%{&filetype} (%{&fileformat}) %*'
local rowcol = '%#StatusLineMode# %l,%c '

vim.o.statusline = mode .. gitinfo .. tabinfo .. fileinfo .. diagnostics .. ' %= ' .. searchcount .. filetype .. rowcol

-- change color on mode change
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function (event)
    local new_mode = event.match:match(':(.)')
    if new_mode == 'i' then
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#00DD66', bold = true })
    elseif new_mode == 'v' or new_mode == 'V' or new_mode == '' then
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#DD44DD', bold = true })
    elseif new_mode == 'c' then
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#00AADD', bold = true })
    elseif new_mode == 'R' then
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#DD3366', bold = true })
    elseif new_mode == 't' then
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#00FF00', bg = '#000000', bold = true })
    else
      vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#333333', bg = '#DDDDDD', bold = true })
    end
    vim.schedule(function() vim.cmd.redrawstatus() end)
  end
})

-- update statusline when new diagnostics appear
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function() vim.schedule(function() vim.cmd.redrawstatus() end) end,
})
