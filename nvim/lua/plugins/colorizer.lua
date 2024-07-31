return {
    {
        'NvChad/nvim-colorizer.lua',
        lazy = false,
        config = function(_, opts)
            require 'colorizer'.setup()
        end,
    }
}
