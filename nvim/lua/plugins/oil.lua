return {
    enabled = true,
    "stevearc/oil.nvim",
    config = function()
        -- It's quite nice and I would probably use this as my main navigator
        -- but it cannot move/copy/etc files/dirs between different nvim instances.
        require("oil").setup()
    end
}
