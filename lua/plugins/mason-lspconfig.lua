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

    local get_installed_package_specs = function ()
      local registry = require("mason-registry")
      local installed = registry.get_installed_package_names()
      local specs = registry.get_all_package_specs()
      local out = {}
      for i, name in ipairs(installed) do
        for _, spec in ipairs(specs) do
          if name == spec.name then
            out[i] = spec
          end
        end
      end
      return out
    end

    -- LSP configuration (lives in lua/lsp/*)
    local names = vim.api.nvim_get_runtime_file('lua/lsp/*.lua', true)
    for _, abs_name in ipairs(names) do
      local name = vim.fn.fnamemodify(abs_name, ':t:r')
      local settings = require('lsp.' .. name)
      vim.lsp.config(name, settings)
    end
    -- enable all installed LSPs
    local installed_specs = get_installed_package_specs()
    local installed_lsp_names = vim.iter(installed_specs):fold({}, function(acc, spec)
      table.insert(acc, spec.neovim and spec.neovim.lspconfig)
      return acc
    end)
    vim.lsp.enable(installed_lsp_names)
  end,
}
