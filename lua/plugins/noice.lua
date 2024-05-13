return {
  'folke/noice.nvim',
  lazy = false,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    cmdline = {
      --view = 'cmdline',
      enabled = true, -- enables the Noice cmdline UI

      format = {
        cmdline = {
          pattern = '^:',
          icon = '',
          lang = 'vim',
        },
        search_down = {
          kind = 'search',
          pattern = '^/',
          icon = ' ',
          lang = 'regex',
        },
        search_up = {
          kind = 'search',
          pattern = '^%?',
          icon = ' ',
          lang = 'regex',
        },
        shell = {
          pattern = '^:!',
          icon = '',
          lang = 'bash',
        },
        filter = {
          pattern = '^:%s!%s+',
          icon = '',
          lang = 'bash',
        },
        lua = {
          pattern = '^:%s*lua%s+',
          icon = '',
          lang = 'lua',
        },
        help = {
          pattern = '^:%s*he?l?p?%s+',
          icon = '',
        },
        open = {
          pattern = '^:%s*e%s+',
          icon = '',
        },
        input = {},
      },
    },

    --routes = {
    --    {
    --        view = "notify",
    --        filter = {
    --            event = "msg_showmode"
    --        },
    --    },
    --},
    messages = {

      enabled = false,

      -- view = false,

      -- view_search = "virtualtext",
    },
    views = {

      --enabled = false, -- enables the Noice cmdline UI
      cmdline_popup = {
        position = {
          row = 13,
          col = '50%',
        },
        size = {
          min_width = 60,
          width = 'auto',
          height = 'auto',
        },
      },
      cmdline_popupmenu = {
        relative = 'editor',
        position = {
          row = 16,
          col = '50%',
        },

        size = {
          width = 60,
          height = 'auto',
          max_height = 15,
        },

        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },

        win_options = {
          winhighlight = {
            Normal = 'Normal',
            FloatBorder = 'NoiceCmdlinePopupBorder',
          },
        },
      },
    },
  },
}
