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
      'markdown',
    }

    require('lspconfig').nil_ls.setup {
      settings = {
        ['nil'] = {
          nix = {
            maxMemoryMB = 3840,
            flake = {
              autoArchive = true,
              autoEvalInputs = true,
            },
          },
        },
      },
    }
    require('lspconfig').rust_analyzer.setup {}

    --lsp.on_attach(function(client, _)
    --  require('lsp-format').on_attach(client)
    --  vim.keymap.set('n', '<space>ca', function()
    --    vim.lsp.buf.code_action { apply = true }
    --  end, bufopts)
    --end)
    lsp.setup()

    local cmp = require 'cmp'
    local cmp_action = require('lsp-zero').cmp_action()

    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
      pattern = 'Cargo.toml',
      callback = function()
        cmp.setup.buffer {
          sources = {
            { name = 'crates' },
          },
        }
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
    local lspkind = require 'lspkind'
    lspkind.init {}

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'cody' },
        { name = 'path' },
        { name = 'buffer' },
      },
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-y>'] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { 'i', 'c' }
        ),
      },
      window = {
        completion = {

          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          col_offset = -3,
          side_padding = 0,
        },
        documentation = {
          border = 'none', -- single|rounded|none
          -- custom colors
          --winhighlight = 'Normal:CmpNormal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          --side_padding = 2, -- * NOT WORKING
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          kind.kind = ' ' .. (strings[1] or '') .. ' '
          kind.menu = '    (' .. (strings[2] or '') .. ')'

          return kind
        end,
      },
    }
    vim.opt.signcolumn = 'yes' -- Disable lsp signals shifting buffer
    --vim.opt.completeopt = 'menuone,noinsert,noselect'

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
