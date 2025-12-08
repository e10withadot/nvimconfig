return {
  -- help pages for language servers
  'neovim/nvim-lspconfig',
  -- actual useful plugins lol
  dependencies = {
    'saghen/blink.cmp',
    'folke/lazydev.nvim',
  },
  config = function()
    -- Language Server settings
    local servers = {
      clangd = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
          },
        },
      },
      pylsp = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      stylua = {},
      ltex_plus = {},
    }
    for name, settings in pairs(servers) do
      vim.lsp.config(name, settings)
      vim.lsp.enable(name)
    end
    --  Runs only when LSP is attached
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- keymaps
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        vim.keymap.set('n', 'grD', require('telescope.builtin').lsp_document_symbols, { buffer = event.buf, desc = 'Document Symbols' })

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        vim.keymap.set('n', 'gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = '[W]orkspace [S]ymbols' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = '[G]oto [D]eclaration' })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
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
