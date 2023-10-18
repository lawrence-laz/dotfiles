return {
	"nvim-neotest/neotest",
	dev = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"Issafalcon/neotest-dotnet",
		{ "lawrence-laz/neotest-zig",    dev = true },
		{ "nvim-neotest/neotest-plenary" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-zig") {
					debug_log = false
				},
				require("neotest-dotnet"),
				require("neotest-plenary"),
			}
		})
	end
}
