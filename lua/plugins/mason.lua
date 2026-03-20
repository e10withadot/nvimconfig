return {
  'mason-org/mason.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  opts = {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  },
  config = function()
    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      }
    }
    -- LSP configuration (lives in lua/lsp/*)
    local names = vim.api.nvim_get_runtime_file('lua/lsp/*.lua', true)
    for _, abs_name in ipairs(names) do
      local name = vim.fn.fnamemodify(abs_name, ':t:r')
      local settings = require('lsp.' .. name)
      vim.lsp.config(name, settings)
    end
    -- enable all installed LSPs
    local registry = require("mason-registry")
    local installed = registry.get_installed_package_names()
    local specs = registry.get_all_package_specs()
    local installed_specs = {}
    for i, name in ipairs(installed) do
      for _, spec in ipairs(specs) do
        if name == spec.name then
          installed_specs[i] = spec
        end
      end
    end
    local installed_lsp_names = vim.iter(installed_specs):fold({}, function(acc, spec)
      table.insert(acc, spec.neovim and spec.neovim.lspconfig)
      return acc
    end)
    vim.lsp.enable(installed_lsp_names)

    --  Runs only when LSP is attached
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp.remaps', { clear = true }),
      callback = function(event)
        -- goto global definition
        vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = event.buf, desc = '[G]oto [D]efinition' })
      end,
    })
  end,
}
