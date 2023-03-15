require("neotest").setup({
	adapters = {
		require("neotest-dotnet")({
			-- dap = { justMyCode = false },
		}),
		-- require("neotest-plenary"),
		-- require("neotest-vim-test")({
		--     ignore_file_types = { "python", "vim", "lua" },
		-- }),
	},
	quickfix = {
		enabled = false,
		open = false,
	},
	icons = {
		child_indent = "│",
		child_prefix = "├",
		collapsed = "─",
		expanded = "╮",
		failed = "X",
		final_child_indent = " ",
		final_child_prefix = "╰",
		non_collapsible = "─",
		passed = "✓",
		running = "",
		running_animated = { "◴", "◷", "◶", "◵" },
		skipped = "怜",
		unknown = "",
	},
	summary = {
		enabled = true,
		animated = true,
		follow = true,
		expand_errors = true,
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			expand_all = "e",
			output = "o",
			short = "O",
			attach = "a",
			jumpto = { "i", "<C-]>" },
			stop = "u",
			run = "r",
			debug = "d",
			mark = "m",
			run_marked = "R",
			debug_marked = "D",
			clear_marked = "M",
			target = "t",
			clear_target = "T",
			next_failed = "J",
			prev_failed = "K",
		},
	},
})

-- Open test explorer (summary)
vim.keymap.set("n", "<C-e>t", function()
	require("neotest").summary.toggle()
	local win = vim.fn.bufwinid("Neotest Summary")
	if win > -1 then
		vim.api.nvim_set_current_win(win)
	end
end)

vim.keymap.set("n", "<leader>rt", require("neotest").run.run)
vim.keymap.set("n", "<leader>r<C-t>", function() require("neotest").run.run({strategy = "dap"}) end)
