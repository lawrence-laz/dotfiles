-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    enabled = true,
    "stevearc/oil.nvim",
    config = function()
        -- It's quite nice and I would probably use this as my main navigator
        -- but it cannot move/copy/etc files/dirs between different nvim instances.
        require("oil").setup({
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc =
                "Open the entry in a horizontal split" },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<tab>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            watch_for_changes = true,
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 70, 0.7 },
            },
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()", -- Uses `_G.get_oil_winbar()` defined above
            },
        })
    end
}
