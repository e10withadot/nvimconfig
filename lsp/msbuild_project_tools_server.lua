vim.filetype.add {
  extension = {
    props = 'msbuild',
    tasks = 'msbuild',
    targets = 'msbuild',
  },
  pattern = {
    [ [[.*\..*proj]] ] = 'msbuild',
  },
}
vim.treesitter.language.register('xml', { 'msbuild' })
return {
  cmd = { 'dotnet', vim.fn.stdpath 'data' .. '\\msbuild_ls\\MSBuildProjectTools.LanguageServer.Host.dll' },
}
