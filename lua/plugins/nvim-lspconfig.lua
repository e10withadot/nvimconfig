return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Mason must be loaded before its dependents so we need to set it up here.
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        --
        local keymap = require 'plugins.nvim-lspconfig.keymaps'
        keymap(event)
        local autocmd = require 'plugins.nvim-lspconfig.autocmd'
        autocmd(event)
      end,
    })
    local diagnostics = require 'plugins.nvim-lspconfig.diagnostics'
    diagnostics()
    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = require 'plugins.nvim-lspconfig.servers'
    local mason = require 'plugins.nvim-lspconfig.mason'
    mason(servers, capabilities)
  end,
}
