local fn = vim.fn

local o = vim.o
return {
  -- Utils
  --
  {
    'lmburns/lf.nvim',
    cmd = 'Lf',
    dependencies = { 'nvim-lua/plenary.nvim', 'akinsho/toggleterm.nvim' },
    opts = {
      winblend = 0,
      highlights = { NormalFloat = { guibg = 'NONE' } },
      border = 'rounded',
      tmux = false,
      escape_quit = true,
      height = fn.float2nr(fn.round(0.90 * o.lines)), -- height of the *floating* window
      width = fn.float2nr(fn.round(0.90 * o.columns)), -- width of the *floating* window
    },
    keys = {
      { '<leader>lf', '<cmd>Lf<cr>', desc = 'LF File Manager' },
    },
  },
  { 'terryma/vim-multiple-cursors' },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  ---- Typescript Tools
  --{
  --  "pmizio/typescript-tools.nvim",
  --  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --  opts = {},
  --},
}
