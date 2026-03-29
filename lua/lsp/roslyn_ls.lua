local mason_root = require("mason.settings").current.install_root_dir
local rzls_path = vim.fn.expand(mason_root .. "/packages/roslyn/libexec/.razorExtension")

return {
  filetypes = { "cs", "razor" },
  cmd = {
    "roslyn",
    "--stdio",
    "--logLevel=Information",
    "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
    "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
    "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
    "--extension=" .. vim.fs.joinpath(rzls_path, "Microsoft.VisualStudioCode.RazorExtension.dll"),
  },
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "openFiles",
      dotnet_compiler_diagnostics_scope = "openFiles",
    },
    ["csharp|razor"] = {
      extension = {
        ["{E12961B7-D4D4-49D8-B27B-78310B0B33CB}"] = {
          enable = true,
        },
      },
    },
  },
}
