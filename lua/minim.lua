local active_lsp = {
  function()
    local msg = ''
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        if client.name == 'null-ls' then
          msg = client.name
        else
          return client.name
        end
      end
    end
    return msg
  end,
  icon = ' LSP:',
}
local show_macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

--local CheckGitWorkspace = function()
--    local filepath = vim.fn.expand('%:p:h')
--    local gitdir = vim.fn.finddir('.git', filepath .. ';')
--    return gitdir and #gitdir > 0 and #gitdir < #filepath
--end

local GetLSPs = function()
  local msg = ''
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if msg == '' then
        msg = client.name

        goto continue
      end

      msg = msg .. ' - ' .. client.name
    end
    ::continue::
  end

  return msg
end
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    bg = "#232232",
    fg = "#cdd6f4",
    none = "",
    cyan = "#89dceb",
    black = "#181825",
    gray = "#45475a",
    magenta = "#cba6f7",
    pink = "#f5c2e7",
    red = "#f38ba8",
    green = "#a6e3a1",
    yellow = "#f9e2af",
    blue = "#89b4fa",
    orange = "#fab387",
    black4 = "#585b70",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.blue },
    b = { fg = colors.fg, bg = colors.gray },
    c = { fg = colors.fg, bg = colors.none },
  },

  insert = { a = { fg = colors.black, bg = colors.red } },
  visual = { a = { fg = colors.black, bg = colors.green } },
  replace = { a = { fg = colors.black, bg = colors.orange } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = 'catppuccin',
    component_separators = '',
    section_separators = '', --{ left = "", right = "" },
  },
  sections = {
    --lualine_a = {
    --    { "mode", separator = { right = "" } },
    --},
    lualine_b = { 'filename' },
    lualine_c = {
      'branch',
      'diff',
      {
        show_macro_recording,
        color = { fg = colors.orange },
      },
    },
    lualine_x = {}, --"filetype" },
    lualine_y = { 'progress' },
    --lualine_z = {
    --    { "location", separator = { right = "" }, left_padding = 2 },
    --},
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = colors.orange },
      },
      GetLSPs,
      --{
      --    '%=', separator = { right = '' }
      --},
      --'filename'
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
