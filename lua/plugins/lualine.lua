return { -- Collection of various small independent plugins/modules
    {
        "nvim-lualine/lualine.nvim",
        -- You can optionally lazy-load heirline on UIEnter
        event = "UIEnter",
        config = function()
            require "lua.plugins.extern.minim"
        end,
    },
}
