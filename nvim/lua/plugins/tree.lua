local function on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end


return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function(_, opts)
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				actions = {
					use_system_clipboard = true,
				},
				view = {
					width = 30,
					preserve_window_proportions = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false, -- false => show
				},
				update_focused_file = {
					enable = true
				},
				on_attach = on_attach,
			})
		end,
	}
}
