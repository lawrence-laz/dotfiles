require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "<F2>", action = "rename" },
				{ key = "<C-Enter>", action = "tabnew" },
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	actions = {
		open_file = {
			-- quit_on_open = true,
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false, -- Show hidden files
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "NvimTree" },
	callback = function()
		vim.keymap.set("n", "?", function()
			vim.cmd([[help nvim-tree-default-mappings]])
		end, { buffer = true })
	end,
})

vim.keymap.set("n", "<C-A-l>", function() -- Toggle file explorer
	if string.match(vim.api.nvim_buf_get_name(0), "NvimTree") then
		vim.cmd("NvimTreeToggle")
	else
		vim.cmd("NvimTreeFocus")
	end
end)
