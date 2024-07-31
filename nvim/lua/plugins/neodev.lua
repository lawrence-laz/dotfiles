-- To check if workspaces are loded, execute:
-- :lua= vim.lsp.get_active_clients({ name = "lua_ls" })[1].config.settings.Lua
return {
    "folke/neodev.nvim",
    config = function()
        require("neodev").setup({
            -- library = { plugins = { "nvim-dap-ui" }, types = true },
            library = {
                plugins = {
                    "neotest"
                },
                types = true
            },
        })
    end
}
