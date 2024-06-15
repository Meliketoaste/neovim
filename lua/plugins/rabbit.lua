return {
  'voxelprismatic/rabbit.nvim',
  cmd = 'Rabbit',
  keys = {
    {
      '<leader>i',
      function()
        require('rabbit').Window 'history'
      end,
      mode = 'n',
      desc = 'Open Rabbit',
    },
    {
      '<leader>p',
      function()
        require('rabbit').Switch 'history' -- Will close current Rabbit window if necessary
        require('rabbit').func.select(1) -- Selects the first entry shown to the user
      end,
      mode = 'n',
      desc = 'Toggle Rabbit',
    },
  },
  opts = {
    colors = {
      term = { fg = '#34ab7e', italic = true },
    },
    window = {
      plugin_name_position = 'title',
    },
  },
}
