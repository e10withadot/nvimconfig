# Setup
`git clone` it to the Neovim config path (`.config/nvim` for Unix and `$LOCALAPPDATA\nvim` for Windows) and you're all set!

# Things I write natively that other people have as plugins
- Statusline
- Session auto load/save
- Autopairs (very rudimentary but works)
- mason/nvim-lspconfig bridge
- treesitter parser auto-install/auto-enable
- colorscheme

# Plugins I use
## Fzf-lua
Just fzf but in a floating window with file preview and a bunch of presets. It works really well, is lighter and faster than Telescope, and I would rather not reimplement all the presets I use from it myself.
## blink.cmp
All-in-one autocompletion suite. Includes file indexing, snippets(including friendly-snippets!), and LSP integration in one condensed autocomplete menu. The native Neovim version is not there yet, but I'm willing to try it if they put snippets and LSP results in one menu.
## oil.nvim
File browser which allows you to edit your directory as any other buffer. Much more convenient and useful than netrw, which has its own convoluted set of keybinds.
## mason.nvim
I actually can live without this, and I did for a while. The problem is, sometimes installing LSPs yourself is tedious, and using Neovim can already be a pain, so it's nice to have one thing that does all the work for you at least.
## vim.sleuth
I don't wanna ruin other people's files with my terrible formatting.
## nvim-treesitter
Technically I rewrote a lot of what this plugin used to do myself, which made me wanna get rid of it. But, it's still helpful as a large repository of all treesitter parsers, so I keep it.
## nvim-lspconfig
Really helpful if I wanna install an LSP without Mason. Also, Mason needs it to know what files to use the LSPs on.
## nvim-web-devicons
I really, but I mean _really_ don't wanna write an icon repo myself.
## Lazy.nvim
Dedicated plugin manager for Neovim. Very _fancy_ and includes lazy loading features that I don't use. Will remove once Neovim 0.12 rolls out and `vim.pack` is a thing.
