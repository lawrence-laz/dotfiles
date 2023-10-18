vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { 'lua' },
	callback = function()
		vim.keymap.set('n', '<leader>kd', require("stylua").format, { buffer = true })
	end
})
