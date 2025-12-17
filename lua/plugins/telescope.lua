-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Telescope Help ]]
      -- HELP COMMAND: `:Telescope help_tags`
      --
      -- SHOW TELESCOPE KEYMAPS:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- Insert default mappings below:
        --
        defaults = {
          -- necessary due to nvim-treesitter rewrite
          preview = {
            treesitter = false,
          },
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local conf = require('telescope.config').values
      local finders = require 'telescope.finders'
      local pickers = require 'telescope.pickers'

      -- tab picker
      local function telescope_tabs()
        local tabs = {}

        for i = 1, (vim.fn.tabpagenr '$') do
          local buflist = vim.fn.tabpagebuflist(i)
          local tab_label = {}

          for _, bufnr in ipairs(buflist) do
            local name = vim.fn.bufname(bufnr)
            if name ~= '' then
              name = vim.fn.fnamemodify(name, ':t')
            end
            table.insert(tab_label, name)
          end

          table.insert(tabs, string.format('%d %s', i, table.concat(tab_label, ', ')))
        end

        pickers
          .new(require('telescope.themes').get_dropdown(), {
            prompt_title = 'Tabs',
            finder = finders.new_table {
              results = tabs,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(_, map)
              local function goto_tab()
                local selection = require('telescope.actions.state').get_selected_entry()
                if selection then
                  local tabnr = tonumber(selection.value:match '^(%d+)')
                  if tabnr then
                    vim.cmd('tabnext ' .. tabnr)
                  end
                end
              end
              map('n', '<CR>', goto_tab)
              map('i', '<CR>', goto_tab)
              return true
            end,
          })
          :find()
      end

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files { hidden = true }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch [G]it' })
      vim.keymap.set('n', '<leader>sw', function()
        builtin.grep_string { search = vim.fn.input 'Search term: ' }
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s8', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>ss', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>t', telescope_tabs, { desc = 'Search [T]abs' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '\\', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[\\] Fuzzily search in current buffer' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
