return {
  -- help pages for language servers
  'neovim/nvim-lspconfig',
  -- actual useful plugins lol
  config = function()
    -- Language Server settings
    local names = vim.api.nvim_get_runtime_file('lua/lsp/*.lua', true)
    for _, abs_name in ipairs(names) do
      local name = vim.fn.fnamemodify(abs_name, ':t:r')
      local settings = require('lsp.' .. name)
      vim.lsp.config(name, settings)
      vim.lsp.enable(name)
    end

    vim.api.nvim_create_user_command('LspSet', function()
      local d = {
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
      }
      local buf = vim.api.nvim_create_buf(false, true)
      local opts = {
        style = 'minimal',
        relative = 'editor',
        width = d.width,
        height = d.height,
        row = d.row,
        col = d.col,
        border = 'rounded',
      }
      local win = vim.api.nvim_open_win(buf, true, opts)
      vim.api.nvim_set_current_win(win)
      vim.cmd.edit(vim.fn.stdpath 'config' .. '/lua/lsp/')
    end, { desc = 'Open Language Server Settings' })

    --  Runs only when LSP is attached
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- goto global definition
        vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = event.buf, desc = '[G]oto [D]efinition' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method 'textDocument/completion' then
          vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })
  end,
}
