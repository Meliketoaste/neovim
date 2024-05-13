return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = {
      ' ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓',
      ' ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
      '▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░',
      '▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ',
      '▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒',
      '░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░',
      '░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░',
      '   ░   ░ ░     ░░   ▒ ░░      ░   ',
      '         ░      ░   ░         ░   ',
      '               ░                  ',
    }
    dashboard.section.header.opts = {
      position = 'center',
      hl = 'Comment',
    }

    require('alpha').setup(require('alpha.themes.dashboard').config)
    dashboard.section.buttons.val = {
      dashboard.button('SPC f f', ' Find File', '<CMD>Telescope find_files<CR>'),
      dashboard.button('SPC f r', ' Recent Files', '<CMD>Telescope oldfiles<CR>'),
      dashboard.button('SPC f g', ' Find in Files', '<CMD>Telescope live_grep<CR>'),
      dashboard.button('q', ' Quit NVIM', ':qa<CR>'),
    }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
