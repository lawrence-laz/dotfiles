return {
    -- gas  - converts to snake case, where "s" stands for snake_case and "ga" is prefix
    "johmsalas/text-case.nvim",
    config = function()
        require('textcase').setup {}
    end
}
