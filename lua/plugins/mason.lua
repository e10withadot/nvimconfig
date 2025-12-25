return {
  'mason-org/mason.nvim',
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
    require('mason').setup { registries = {
      'github:mason-org/mason-registry',
      'github:Crashdummyy/mason-registry',
    } }
  end,
}
