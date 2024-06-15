return {
  'numToStr/FTerm.nvim',
  config = function()
    require('FTerm').setup {
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
      border = 'single',
    }

    --vim.keymap.set('n', '<leader>i', '<CMD>lua require("FTerm").toggle()<CR>', {
    --  desc = 'Toggle Terminal',
    --})
    --vim.keymap.set('t', '<leader>i', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', {
    --  desc = 'Toggle Terminal',
    --})
  end,
}
