vim.pack.add {
  'https://www.github.com/neovim/nvim-lspconfig', -- lsp defaults
  'https://www.github.com/mason-org/mason.nvim' -- lsp repo
}
-- a separate column for signs
vim.o.signcolumn = 'yes'
-- diagnostic options
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    severity = vim.diagnostic.severity.ERROR,
  },
}

require('mason').setup {
  ui = {
    icons = {
      package_installed = 'I',
      package_pending = '...',
      package_uninstalled = 'X',
    },
  },
  -- roslyn has a third-party repo
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

-- LSP configuration (lives in lsp/*)
local names = vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua", false, true)
for _, abs_name in ipairs(names) do
  local name = vim.fn.fnamemodify(abs_name, ':t:r')
  local ok, settings = pcall(require, 'lsp.' .. name)

  -- catch config errors
  if not ok then
    vim.notify("Failed to load: lsp." .. name, vim.log.levels.WARN)
  elseif type(settings) ~= "table" then
    vim.notify(name .. " did not return table (discarded)", vim.log.levels.WARN)
  else
    vim.lsp.config(name, settings)
  end
end

-- enable all installed LSPs
local installed_specs = get_installed_package_specs()
local installed_lsp_names = vim.iter(installed_specs):fold({}, function(acc, spec)
  local lsp_name = spec.neovim and spec.neovim.lspconfig
  -- exception for roslyn
  if not lsp_name and spec.name == 'roslyn' then
    lsp_name = 'roslyn_ls'
  end
  table.insert(acc, lsp_name)
  return acc
end)
vim.lsp.enable(installed_lsp_names)
