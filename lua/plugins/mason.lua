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
    local installed_packages = require("mason-registry").get_installed_packages()
    local installed_lsp_names = vim.iter(installed_packages):fold({}, function(acc, pack)
      table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
      return acc
    end)
    vim.lsp.enable(installed_lsp_names)
  end,
}
