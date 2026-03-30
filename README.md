# Requirements
- Neovim 0.12+
- git
- fzf
- ripgrep
- tree-sitter cli

# Setup
`git clone` it to the Neovim config path (`.config/nvim` for Unix and `$LOCALAPPDATA\nvim` for Windows) and you're all set!

# Structure
**init.lua** is where all the important options that should be loaded first are.

**plugin/** is where all added functionalities that can be loaded in parallel reside.

**colors/** keeps my colorscheme, a custom version of carbonfox called "oxidefox".

**lsp/** keeps my language server configs.

This structure ensures that if one module breaks, the entire system doesn't. Unless something is wrong with the **init.lua**, an error in a single file will only affect that one file.
