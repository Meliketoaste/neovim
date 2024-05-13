return {
  -- Telescope
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    lazy = true,
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>ft', '<cmd>Telescope live_grep<cr>', desc = 'Search Text in Files' },
      { '<leader>bi', '<cmd>Telescope buffers<cr>', desc = 'List Buffers' },
      { '<M-x>', '<cmd>Telescope commands<cr>', desc = 'Run Command' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            preview_width = 0.55,
            horizontal = {
              size = {
                width = '95%',
                height = '95%',
              },
            },
          },
          pickers = {
            find_files = {
              theme = 'dropdown',
            },
          },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-d>'] = require('telescope.actions').move_selection_previous,
            },
          },
        },
        --defaults = {
        --    prompt_prefix = '   ',
        --    selection_caret = '  ',
        --    initial_mode = 'insert',
        --    selection_strategy = 'reset',
        --    sorting_strategy = 'ascending',
        --    layout_strategy = 'horizontal',
        --    layout_config = {
        --        horizontal = {
        --            prompt_position = 'top',
        --            preview_width = 0.55,
        --            results_width = 0.8,
        --        },
        --        vertical = {
        --            mirror = false,
        --        },
        --        width = 0.87,
        --        height = 0.80,
        --        preview_cutoff = 120,
        --    },
        --    path_display = { 'truncate' },
        --    winblend = 0,
        --    -- border = {},
        --    --borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        --    color_devicons = true,
        --    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        --    -- Keymaps
        --    mappings = {
        --        n = {
        --            ['d'] = require('telescope.actions').delete_buffer,
        --        },
        --    },
        --},
      }
      pcall(require('telescope').load_extension, 'fzf')

      -- Theming
      local colors = require('catppuccin.palettes').get_palette()
      local TelescopeColor = {
        --TelescopeMatching = { fg = colors.flamingo },
        --TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
        --TelescopePromptPrefix = { fg = colors.red },
        TelescopePromptNormal = { bg = '#050517' },

        TelescopeResultsNormal = { bg = '#050517' },

        TelescopePreviewNormal = { bg = '#050517' },
        --TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        --TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        --TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        --TelescopePromptTitle = { bg = colors.red, fg = colors.mantle },
        --TelescopeResultsTitle = { fg = colors.mantle },
        --TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      --Goto deff from kickstart-nvim
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
  -- Repo Jumping
  {
    'cljoly/telescope-repo.nvim',
    keys = {
      { '<leader>rr', '<cmd>Telescope repo list<cr>', desc = 'Open git repository' },
    },
    config = function()
      require('telescope').load_extension 'repo'
    end,
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    config = function()
      require('telescope').load_extension 'media_files'
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require('telescope').load_extension 'frecency'
    end,
  },
  {
    'mrcjkb/telescope-manix',
    keys = {
      { '<leader>fm', '<cmd>Telescope manix<cr>', desc = 'Search Nix Options and Utils' },
    },
    -- ...
  },
}
