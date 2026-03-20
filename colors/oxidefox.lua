local cmd = vim.api.nvim_command

cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  cmd("syntax reset")
end

vim.g.colors_name = "oxidefox"

local hi = function(group, opts)
  local gui = opts.gui or "NONE"
  local sp  = opts.sp  or "NONE"
  local fg  = opts.fg  or "NONE"
  local bg  = opts.bg  or "NONE"
  cmd(string.format(
    "highlight %s guifg=%s guibg=%s gui=%s guisp=%s",
    group, fg, bg, gui, sp
  ))
end


-- ================================
--  Hard‑coded palette (no Shade / C)
-- ================================

local palette = {
  black   = "#282828",
  red     = "#EE5396",
  green   = "#25be6a",
  yellow  = "#BDA808",
  blue    = "#78A9FF",
  magenta = "#BE95FF",
  cyan    = "#33B1FF",
  white   = "#DFDFE0",
  orange  = "#DBA43D",
  pink    = "#FF7EB6",

  comment = "#6b7280",  -- approx bg:blend(fg, 0.4)

  sel0    = "#2a2a2a",  -- popup / visual
  sel1    = "#525253",  -- search / popup sel
}

local syntax = {
  bracket     = palette.fg2,
  builtin0    = palette.red,
  builtin1    = palette.cyan,
  builtin2    = palette.orange,
  builtin3    = palette.red,
  comment     = palette.comment,
  conditional = palette.magenta,
  const       = palette.orange,
  field       = palette.blue,
  func        = palette.blue,
  ident       = palette.cyan,
  keyword     = palette.magenta,
  preproc     = palette.pink,
  regex       = palette.yellow,
  statement   = palette.magenta,
  string      = palette.green,
  type        = palette.yellow,
  variable    = palette.white,
}

local diag = {
  error = palette.red,
  warn  = palette.orange,
  info  = palette.blue,
  hint  = palette.magenta,
  ok    = palette.green,
}

local diag_bg = {
  error = "#271c21",  -- bg:blend(red, 0.15)
  warn  = "#212120",  -- bg:blend(orange, 0.15)
  info  = "#1c2127",  -- bg:blend(blue, 0.15)
  hint  = "#271c21",  -- bg:blend(magenta, 0.15)
  ok    = "#1c2120",  -- bg:blend(green, 0.15)
}

local diff = {
  add    = "#1c2720",  -- bg:blend(green, 0.15)
  delete = "#271c20",  -- bg:blend(red, 0.15)
  change = "#202327",  -- bg:blend(blue, 0.15)
  text   = "#2a3035",  -- bg:blend(cyan, 0.3)
}

local git = {
  add      = palette.green,
  removed  = palette.red,
  changed  = palette.yellow,
  conflict = palette.orange,
  ignored  = palette.comment,
}


-- ================================
--  Core UI
-- ================================

hi("Visual",      { bg = palette.sel0 })
hi("VisualNOS",   { bg = palette.sel0 })

hi("Search",      { bg = palette.sel1 })
hi("IncSearch",   { bg = palette.sel1 })

hi("PmenuSel",    { bg = palette.sel0 })

hi("MatchParen",  { gui = "bold" })


-- ================================
--  Syntax
-- ================================

hi("Comment",     { fg = syntax.comment, gui = "italic" })

hi("Constant",    { fg = syntax.const })
hi("String",      { fg = syntax.string })

hi("Identifier",  { fg = syntax.ident })
hi("Function",    { fg = syntax.func, gui = "bold" })

hi("Statement",   { fg = syntax.statement })
hi("Keyword",     { fg = syntax.keyword })
hi("Conditional", { fg = syntax.conditional })

hi("Type",        { fg = syntax.type })

hi("Number",      { fg = syntax.const })
hi("Boolean",     { fg = syntax.const })

hi("PreProc",     { fg = syntax.preproc })

hi("Operator",    { fg = syntax.operator })

hi("SpecialKey",  { fg = syntax.regex })

hi("Todo",        { fg = syntax.comment, gui = "bold,italic" })


-- ================================
--  Diagnostics
-- ================================

hi("DiagnosticError", { fg = diag.error })
hi("DiagnosticWarn",  { fg = diag.warn })
hi("DiagnosticInfo",  { fg = diag.info })
hi("DiagnosticHint",  { fg = diag.hint })
hi("DiagnosticOk",    { fg = diag.ok })

hi("DiagnosticVirtualTextError", { fg = diag.error, bg = diag_bg.error })
hi("DiagnosticVirtualTextWarn",  { fg = diag.warn,  bg = diag_bg.warn })
hi("DiagnosticVirtualTextInfo",  { fg = diag.info,  bg = diag_bg.info })
hi("DiagnosticVirtualTextHint",  { fg = diag.hint,  bg = diag_bg.hint })
hi("DiagnosticVirtualTextOk",    { fg = diag.ok,    bg = diag_bg.ok })

hi("DiagnosticUnderlineError",   { sp = diag.error, gui = "undercurl" })
hi("DiagnosticUnderlineWarn",    { sp = diag.warn,  gui = "undercurl" })
hi("DiagnosticUnderlineInfo",    { sp = diag.info,  gui = "undercurl" })
hi("DiagnosticUnderlineHint",    { sp = diag.hint,  gui = "undercurl" })
hi("DiagnosticUnderlineOk",      { sp = diag.ok,    gui = "undercurl" })


-- ================================
--  Diff / git
-- ================================

hi("DiffAdd",     { bg = diff.add })
hi("DiffDelete",  { bg = diff.delete })
hi("DiffChange",  { bg = diff.change })
hi("DiffText",    { bg = diff.text })

hi("GitSignsAdd",      { fg = git.add })
hi("GitSignsChange",   { fg = git.changed })
hi("GitSignsDelete",   { fg = git.removed })

-- treesitter
hi('@variable.builtin', { fg = palette.red } )
hi('@variable.parameter', { fg = palette.blue } )
hi('@constant', { fg = palette.cyan } )
hi('@function.builtin', { fg = palette.red } )
hi('@function.macro', { fg = palette.red } )
