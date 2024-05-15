--return {
--  {
--    'catppuccin/nvim',
--    name = 'catppuccin',
--    lazy = false,
--    priority = 1000,
--    config = function()
--      require('catppuccin').setup {
--        color_overrides = {
--          all = {
--            base = '#11111b',
--          },
--        },
--        custom_highlights = function(C)
--
--          return {
--            --CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
--            --CmpItemKindKeyword = { fg = C.base, bg = C.red },
--            --CmpItemKindText = { fg = C.base, bg = C.teal },
--            --CmpItemKindMethod = { fg = C.base, bg = C.blue },
--            --CmpItemKindConstructor = { fg = C.base, bg = C.blue },
--            --CmpItemKindFunction = { fg = C.base, bg = C.blue },
--            --CmpItemKindFolder = { fg = C.base, bg = C.blue },
--            --CmpItemKindModule = { fg = C.base, bg = C.blue },
--            --CmpItemKindConstant = { fg = C.base, bg = C.peach },
--            --CmpItemKindField = { fg = C.base, bg = C.green },
--            --CmpItemKindProperty = { fg = C.base, bg = C.green },
--            --CmpItemKindEnum = { fg = C.base, bg = C.green },
--            --CmpItemKindUnit = { fg = C.base, bg = C.green },
--            --CmpItemKindClass = { fg = C.base, bg = C.yellow },
--            --CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
--            --CmpItemKindFile = { fg = C.base, bg = C.blue },
--            --CmpItemKindInterface = { fg = C.base, bg = C.yellow },
--            --CmpItemKindColor = { fg = C.base, bg = C.red },
--            --CmpItemKindReference = { fg = C.base, bg = C.red },
--            --CmpItemKindEnumMember = { fg = C.base, bg = C.red },
--            --CmpItemKindStruct = { fg = C.base, bg = C.blue },
--            --CmpItemKindValue = { fg = C.base, bg = C.peach },
--            --CmpItemKindEvent = { fg = C.base, bg = C.blue },
--            --CmpItemKindOperator = { fg = C.base, bg = C.blue },
--            --CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
--            --CmpItemKindCopilot = { fg = C.base, bg = C.teal },
--            NormalFloat = { bg = "#11111b"},
--          }
--        end,
--      }
--      vim.cmd [[colorscheme catppuccin-mocha]]
--    end,
--  },
--}

--return {
--  -- the colorscheme should be available when starting Neovim
--  {
--    "folke/tokyonight.nvim",
--    lazy = false, -- make sure we load this during startup if it is your main colorscheme
--    priority = 1000, -- make sure to load this before all the other start plugins
--    config = function()
--      -- load the colorscheme here
--      vim.cmd([[colorscheme tokyonight]])
--    end,
--  },
--
--}
return {

  -- tokyonight
  --{
  --  "folke/tokyonight.nvim",
  --  lazy = true,
  --  opts = { style = "moon" },
  --},

  -- catppuccin
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = false,
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {
          mocha = {
            -- CUSTOM:
            base = '#050517',

            -- DEFAULT mocha for reference:
            -- rosewater = "#f5e0dc",
            -- flamingo = "#f2cdcd",
            -- pink = "#f5c2e7",
            -- mauve = "#cba6f7",
            -- red = "#f38ba8",
            -- maroon = "#eba0ac",
            -- peach = "#fab387",
            -- yellow = "#f9e2af",
            -- green = "#a6e3a1",
            -- teal = "#94e2d5",
            -- sky = "#89dceb",
            -- sapphire = "#74c7ec",
            -- blue = "#89b4fa",
            -- lavender = "#b4befe",
            -- text = "#cdd6f4",
            -- subtext1 = "#bac2de",
            -- subtext0 = "#a6adc8",
            -- overlay2 = "#9399b2",
            -- overlay1 = "#7f849c",
            -- overlay0 = "#6c7086",
            -- surface2 = "#585b70",
            -- surface1 = "#45475a",
            -- surface0 = "#313244",
            -- base = "#1e1e2e",
            -- mantle = "#181825",
            -- crust = "#11111b",
          },
        },
        custom_highlights = function(C)
          return {
            -- Example (see: https://github.com/ayamir/nvimdots/wiki/Usage#get-catppuccin-colors for more):
            -- LspReferenceText = { bg = colors.bg_highlight },
            -- LspReferenceRead = { bg = colors.bg_highlight },
            -- LspReferenceWrite = { bg = colors.bg_highlight },
            -- LspDiagnosticsDefaultError = { fg = colors.red },
            -- LspDiagnosticsDefaultWarning = { fg = colors.yellow },
            -- LspDiagnosticsDefaultInformation = { fg = colors.blue },
            -- LspDiagnosticsDefaultHint = { fg = colors.cyan },

            -- Comment = { fg = colors.flamingo },
            -- TabLineSel = { bg = colors.pink },
            -- CmpBorder = { fg = colors.surface2 },
            Pmenu = { bg = C.none },
            -- Normal = { bg = "#050517" },
            -- TODO: move this to highlight_overrides:

            --CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
            --CmpItemKindKeyword = { fg = C.base, bg = C.red },
            --CmpItemKindText = { fg = C.base, bg = C.teal },
            --CmpItemKindMethod = { fg = C.base, bg = C.blue },
            --CmpItemKindConstructor = { fg = C.base, bg = C.blue },
            --CmpItemKindFunction = { fg = C.base, bg = C.blue },
            --CmpItemKindFolder = { fg = C.base, bg = C.blue },
            --CmpItemKindModule = { fg = C.base, bg = C.blue },
            --CmpItemKindConstant = { fg = C.base, bg = C.peach },
            --CmpItemKindField = { fg = C.base, bg = C.green },
            --CmpItemKindProperty = { fg = C.base, bg = C.green },
            --CmpItemKindEnum = { fg = C.base, bg = C.green },
            --CmpItemKindUnit = { fg = C.base, bg = C.green },
            --CmpItemKindClass = { fg = C.base, bg = C.yellow },
            --CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
            --CmpItemKindFile = { fg = C.base, bg = C.blue },
            --CmpItemKindInterface = { fg = C.base, bg = C.yellow },
            --CmpItemKindColor = { fg = C.base, bg = C.red },
            --CmpItemKindReference = { fg = C.base, bg = C.red },
            --CmpItemKindEnumMember = { fg = C.base, bg = C.red },
            --CmpItemKindStruct = { fg = C.base, bg = C.blue },
            --CmpItemKindValue = { fg = C.base, bg = C.peach },
            --CmpItemKindEvent = { fg = C.base, bg = C.blue },
            --CmpItemKindOperator = { fg = C.base, bg = C.blue },
            --CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
            --CmpItemKindCopilot = { fg = C.base, bg = C.teal },
            WhichKeyFloat = { bg = '#0f0f24' },
            WhichKeyBorder = { bg = '#89b4fa' },
            LazyNormal = { bg = '#050517' },
            --TroubleNormal = { bg = "" },
            --MasonNormal = { bg = "#050517" },
            NormalFloat = { bg = C.base },
            Normal = { bg = '#0e0e16' },
            -- htmlBold = { fg = "rose" },
            -- markdownBold = { fg = "rose" },
            -- NeoTreeNormal = { bg = "#050517" },
            -- StatusLine = { bg = "#050517" },
            -- lualine_a_insert = { bg = "#050517" },
            ['@constant.builtin'] = { fg = C.peach, style = {} },
            ['@comment'] = { fg = C.surface2, style = { 'italic' } },
          }
        end,
        highlight_overrides = {
          mocha = function(c)
            return {
              NeoTreeNormal = { bg = c.base },
              -- HarpoonNormal = { bg = c.base },
            }
          end,
        },
        -- default_integrations = false,
        integrations = {
          alpha = true,
          cmp = true,
          flash = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          navic = { enabled = true, custom_bg = 'lualine' },
          neotest = true,
          noice = true,
          notify = true,
          neotree = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
