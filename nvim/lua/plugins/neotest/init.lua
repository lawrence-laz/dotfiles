return {
    "nvim-neotest/neotest",
    dev = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "Issafalcon/neotest-dotnet",
        { "lawrence-laz/neotest-zig",    tag = "1.3.1", dev = true },
        { "nvim-neotest/neotest-plenary" },
        "nvim-neotest/neotest-go",
    },
    config = function()
        require("neotest").setup({
            log_level = vim.log.levels.TRACE,
            adapters = {
                require("neotest-zig") {
                    debug_log = true,
                    dap = {
                        adapter = "codelldb"
                    },
                },
                require("neotest-dotnet"),
                require("neotest-go"),
                -- require("neotest-plenary"),
            }
        })
    end
}
