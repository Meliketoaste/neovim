return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    jump = { autojump = false },
    label = { uppercase = false, reuse = 'none' },
    modes = { char = { jump_labels = true } },
  },
  keys = {
    {
      '<leader>s',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    --{
    --  'S',
    --  mode = { 'n', 'o', 'x' },
    --  function()
    --    require('flash').treesitter()
    --  end,
    --  desc = 'Flash Treesitter',
    --},
  },
}
