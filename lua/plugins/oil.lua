--return {
--  'stevearc/oil.nvim',
--  opts = {},
--  -- Optional dependencies
--  dependencies = { 'nvim-tree/nvim-web-devicons' },
--  keys = {
--    { '<leader>fd', '<cmd>Oil<cr> <cmd>lua ', desc = 'File Browser' },
--  },
--  config = function()
--    require('oil').setup {
--      skip_confirm_for_simple_edits = true,
--    }
--  end,
--
--     -- action = ":Oil --float<CR>";
--}
--
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = { { "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil buffer" } },
    enabled = true,

    -- {{{ Option
    opts = function(_, opts)
        opts.columns = { "icon" }
        opts.prompt_save_on_select_new_entry = true
        opts.use_default_keymaps = false

        opts.keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-x>"] = "actions.select_split",
            ["q"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["g."] = "actions.toggle_hidden",
        }

        -- keymaps = {
        --   "g?" = "actions.show_help";
        --   "<CR>" = "actions.select";
        --   "<C-\\>" = "actions.select_vsplit";
        --   "<C-enter>" = "actions.select_split"; # this is used to navigate left
        --   "<C-t>" = "actions.select_tab";
        --   "<C-p>" = "actions.preview";
        --   "<C-c>" = "actions.close";
        --   "<C-r>" = "actions.refresh";
        --   "-" = "actions.parent";
        --   "_" = "actions.open_cwd";
        --   "`" = "actions.cd";
        --   "~" = "actions.tcd";
        --   "gs" = "actions.change_sort";
        --   "gx" = "actions.open_external";
        --   "g." = "actions.toggle_hidden";
        --   "q" = "actions.close";
        -- };

        opts.float = {
            border = "rounded",
            -- max_height = 25,
            -- max_width = 50,
            -- padding = 0,
            win_options = { winblend = 0, },
        }
        opts.view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
        }
    end,

    -- ----------------------------------------------------------------------- }}}
    -- {{{ Configuration

    config = function(_, opts)
        require("oil").setup(opts)
    end,

    -- ----------------------------------------------------------------------- }}}
}
