return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- count num of diagnostics
    local diagnostic_count = function()
      local counts = {
        err = 0,
        warn = 0,
        info = 0,
        hint = 0,
      }
      local dia_table = vim.diagnostic.get()
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

    -- statusline
    require('mini.statusline').setup()
    -- set highlights
    vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineError', { link = 'DiagnosticError' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineWarn', { link = 'DiagnosticWarn' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineInfo', { link = 'DiagnosticInfo' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineHint', { link = 'DiagnosticHint' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineSearch', { link = 'MiniStatuslineFilename' })

    local statusline = function()
      -- config sections
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local dc = diagnostic_count()
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local r, c = unpack(vim.api.nvim_win_get_cursor(0))
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }

      return MiniStatusline.combine_groups {
        -- hide normal mode
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        -- render diagnostics separately
        { hl = 'MiniStatuslineError', strings = { dc.err > 0 and '󰅚 ' .. tostring(dc.err) } },
        { hl = 'MiniStatuslineWarn', strings = { dc.warn > 0 and '󰀪 ' .. tostring(dc.warn) } },
        { hl = 'MiniStatuslineInfo', strings = { dc.info > 0 and '󰋽 ' .. tostring(dc.info) } },
        { hl = 'MiniStatuslineHint', strings = { dc.hint > 0 and '󰌶 ' .. tostring(dc.hint) } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineSearch', strings = { search ~= '' and ' ' .. search } },
        { hl = 'MiniStatuslineDevinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { tostring(r) .. ',' .. tostring(c) } },
      }
    end

    MiniStatusline.config = {
      content = {
        active = statusline,
        inactive = statusline,
      },
      use_icons = true,
    }
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.sessions').setup { autoread = true }
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
