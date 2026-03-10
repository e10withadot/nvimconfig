return {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/packages/roslyn/roslyn",
    "--logLevel",
    "Information",
    '--extensionLogDirectory',
    vim.fs.joinpath(vim.uv.os_tmpdir(), 'roslyn_ls/logs'),
    "--stdio",
  },
  ft = { "cs", "razor" },
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "openFiles",
      dotnet_compiler_diagnostics_scope = "openFiles",
    },
  },
}
