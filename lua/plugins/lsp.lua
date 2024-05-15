return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'onsails/lspkind.nvim' },
    { 'folke/neodev.nvim' },

    -- Linting
    { 'mfussenegger/nvim-lint' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    -- Esthetic
    { 'folke/trouble.nvim' },

    -- Misc
    {
      'stevearc/conform.nvim',
    },

    -- Flutter
    {
      'akinsho/flutter-tools.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
      config = true,
    },

    -- Rust
    { 'simrat39/rust-tools.nvim' },
    {
      'saecki/crates.nvim',
      tag = 'v0.4.0',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('crates').setup()
      end,
    },
  },
  config = function()
    local lsp = require 'lsp-zero'

    require('neodev').setup {}

    lsp.preset 'recommended'
    lsp.nvim_workspace()
    lsp.set_preferences {
      sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»',
      },
    }

    -- Configure Servers
    lsp.setup_servers {
      'lua_ls',
      'rust_analyzer',
      'zls',
      'tsserver',
      'clangd',
      'tailwindcss',
      'dartls',
      'gopls',
      --'typst-lsp',
      'ols',
      'julials',
    }

    require('lspconfig').nil_ls.setup {
      settings = {
        ['nil'] = {
          nix = {
            maxMemoryMB = 7680,
            flake = {
              autoArchive = true,
              autoEvalInputs = true,
            },
          },
        },
      },
    }

    lsp.on_attach(function(client, _)
      require('lsp-format').on_attach(client)
      vim.keymap.set('n', '<space>ca', function()
        vim.lsp.buf.code_action { apply = true }
      end, bufopts)
    end)
    lsp.setup()

    local cmp = require 'cmp'
    local cmp_action = require('lsp-zero').cmp_action()

    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
      pattern = 'Cargo.toml',
      callback = function()
        cmp.setup.buffer { sources = { { name = 'crates' } } }
      end,
    })

    local opts = { silent = true }
    vim.keymap.set('n', '<leader>cp', require('crates').show_popup, opts)

    vim.api.nvim_set_hl(0, 'CmpNormal', { bg = '#1e1e2e' })
    vim.api.nvim_set_hl(0, 'CmpBg', { bg = '#31324a' })

    --local colors = require('catppuccin.palettes').get_palette()
    --require('modes').setup {
    --  colors = {
    --    copy = colors.peach,
    --    delete = colors.red,
    --    insert = colors.blue,
    --    visual = colors.lavender,
    --  },

    cmp.setup {
      mapping = {
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
      },
      window = {
        completion = {
          border = 'none', -- single|rounded|none
          -- custom colors
          --winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None", -- BorderBG|FloatBorder
          --side_padding = settings.cmp_style == "default" and 1 or 0, -- padding at sides
          --col_offset = settings.cmp_style == "default" and -1 or -4, -- move floating box left or right

          winhighlight = 'Normal:CmpNormal,FloatBorder:Pmenu,Search:None,CursorLine:CmpBg',
          col_offset = -3,
          side_padding = 0,
        },

        documentation = {
          border = 'none', -- single|rounded|none
          -- custom colors
          winhighlight = 'Normal:CmpNormal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
          side_padding = 2, -- * NOT WORKING
        },
      },
      formatting = {

        --fields = { 'kind', 'abbr', 'menu' },
        format = function(...)
          return require('lspkind').cmp_format { with_text = true }(...)
        end,
      },
    }

    vim.opt.signcolumn = 'yes' -- Disable lsp signals shifting buffer

    vim.diagnostic.config {
      virtual_text = true,
    }

    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'alejandra' },
        rust = { 'rustfmt' },
        markdown = { 'mdformat' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_md = 500,
      },
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    })

    -- lint
    require('lint').linters_by_ft = {
      nix = { 'statix' },
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
