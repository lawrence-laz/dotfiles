require("telescope").load_extension("command_center")

local when = function(arg)
	return function()
		if vim.fn.mode() == "n" then
			vim.cmd(arg.normal)
		else
			vim.cmd(arg.visual)
		end
	end
end

vim.keymap.set("n", "<C-S-p>", "<CMD>Telescope command_center<CR>")
vim.keymap.set("v", "<C-S-p>", "<CMD>Telescope command_center<CR>")

require("command_center").add({
	{
		desc = "Word wrap",
		cmd = "<CMD>set wrap!<CR>",
	},
	--{
	--   desc = "Open selection in GitHub",
	--  cmd = open_visual_in_github,
	--},
	{
		desc = "GitHub: Open project",
		cmd = "<CMD>OpenGithubProject<CR>",
	},
	{
		desc = "Close all tabs",
		cmd = "<CMD>lua CloseAllBuffers()<CR>",
	},

	{
		desc = "Close all tabs but current",
		cmd = "<CMD>lua CloseAllButCurrent()<CR>",
	},
	{
		desc = "Close all tabs but pinned",
		cmd = "<CMD>BufferCloseAllButPinned<CR>",
	},
	{
		desc = "Pin current tab",
		cmd = "<CMD>BufferLineTogglePin<CR>",
	},
	{
		desc = "Git: Blame current line",
		cmd = "<CMD>Gitsigns blame_line<CR>",
	},
	{
		desc = "Git: Show current file history",
		cmd = "<CMD>LazyGitFilterCurrentFile<CR>",
	},
	{
		desc = "Git: Open LazyGit",
		cmd = "<CMD>LazyGit<CR>",
	},
	{
		desc = "Search help",
		cmd = "<CMD>Telescope help_tags<CR>",
	},
	{
		desc = "Search in open files",
		cmd = function()
			require("telescope.builtin").live_grep({ grep_open_files = true })
		end,
	},
	{
		desc = "Insert symbols",
		cmd = "<CMD>Telescope symbols<CR>",
	},
	-- {
	--     desc = "Toggle diagnostics",
	--     cmd = require 'lsp_lines'.toggle
	-- },
	{
		desc = "Debugger: Terminate",
		cmd = "<CMD>DapTerminate<CR>",
	},
	{
		desc = "Go to next error",
		cmd = "<CMD>lua vim.diagnostic.goto_next{severity={min=vim.diagnostic.",
	},
	{
		desc = "Undo: Toggle Tree",
		cmd = "<CMD>:UndotreeToggle<CR>",
	},
	{
		desc = "Go to next warning",
		cmd = "<CMD>lua vim.diagnostic.goto_next{severity=vim.diagnostic.sever",
	},
	-- ./gitsigns.lua
	{
		desc = "Git: Toggle changes",
		cmd = function()
			require("gitsigns").toggle_linehl()
			require("gitsigns").toggle_deleted()
		end,
	},
	{
		desc = "Git: Diff with HEAD",
		cmd = "<CMD>lua require'gitsigns'.diffthis('HEAD')<CR>",
	},
	{
		desc = "Git: Blame current line",
		cmd = "<CMD>lua require'gitsigns'.blame_line{full=true}<CR>",
	},
	-- trouble
	{
		desc = "Diagnostics: View Errors (Workspace)",
		keys = { "n", "<C-\\>e", { noremap = true } },
		cmd = "<CMD>TroubleToggle workspace_diagnostics<CR>",
	},
	{
		desc = "Diagnostics: View Errors (Document)",
		cmd = "<CMD>TroubleToggle document_diagnostics<CR>",
	},
	{
		desc = "Diagnostics: Search Errors",
		cmd = function()
			require("telescope.builtin").diagnostics({ severity_limit = "warn" })
		end,
	},
	{
		desc = "Diagnostics: Show details",
		keys = { "n", "<leader>se", { noremap = true } },
		cmd = "<CMD>lua vim.diagnostic.open_float()<CR>",
	},
	{
		desc = "Show outline",
		cmd = "<CMD>Lspsaga outline<CR>",
	},
	{
		desc = "Find: Symbols in Workspace",
		cmd = "<CMD>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>",
	},
	{
		desc = "Find: Symbols in Document",
		cmd = "<CMD>lua require'telescope.builtin'.lsp_document_symbols()<CR>",
	},
	{
		desc = "Packer: Synchronize",
		cmd = "<CMD>PackerSync<CR>",
	},
	{
		desc = "Packer: Install",
		cmd = "<CMD>PackerInstall<CR>",
	},
	{
		desc = "Tmux: Split window with current directory",
		cmd = '<CMD>silent !tmux split-window -c "`pwd`"<CR>',
	},
	{
		desc = "Sort ascending",
		cmd = "<CMD>lua vim.cmd[[Sort]]<CR>",
	},
	{
		desc = "Insert date",
		cmd = "<CMD>lua vim.cmd[[pu=strftime('%Y-%m-%d')]]<CR>",
	},
	-- { desc = "Change case", cmd = '<CMD>call b:VM_Selection.Search.case()<cr>' },
	{ desc = "Run the nearest test", cmd = '<CMD>lua require("neotest").run.run()<CR>' },
	{ desc = "Run current file tests", cmd = '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>' },
	{ desc = "Debug the nearest test", cmd = '<CMD>lua require("neotest").run.run({strategy = "dap"})<CR>' },
	{ desc = "Stop the nearest test", cmd = '<CMD>lua require("neotest").run.stop()<CR>' },
	{ desc = "Attach to the nearest test", cmd = '<CMD>lua require("neotest").run.attach()<CR>' },
	{ desc = "Show test output", cmd = '<CMD>lua require("neotest").output.open()<CR>' },
	{ desc = "Toggle output pannel", cmd = '<CMD>lua require("neotest").output_panel.toggle()<CR>' },
	{ desc = "Toggle tests explorer (summary)", cmd = '<CMD>lua require"neotest".summary.toggle()<CR>' },
	{ desc = "Markdown: Paste image and link", cmd = '<CMD>lua require("telekasten").paste_img_and_link()<CR>' },
	{ desc = "Markdown: Toggle todo", cmd = '<CMD>lua require("telekasten").toggle_todo()<CR>' },
	{ desc = "Markdown: Preview image", cmd = '<CMD>lua require("telekasten").preview_img()<CR>' },
	{ desc = "Show key mappings", cmd = "<CMD>lua ShowMappingsInBuffer()<CR>" },
	{ desc = "File: Copy full path", cmd = "<CMD>redir @* | ech expand('%:p') | redir END<CR>" },
	{ desc = "File: Show unsaved changes", cmd = "<CMD>:w !diff % -<CR>" },
	{ desc = "File: Reveal in file explorer", cmd = "<CMD>:!nautilus '%:p:h'<CR>" },
	{ desc = "Language Server: Restart", cmd = "<CMD>:LspRestart<CR>" },
	{ desc = "Language Server: Info", cmd = "<CMD>:LspInfo<CR>" },
	{ desc = "Lua: Reload module", cmd = "<CMD>:Telescope reloader<CR>" },
	{ desc = "GitHub: Open in Browser", cmd = "<CMD>!gh browse<CR>" },
	{ desc = "Diff: Current split", cmd = "<CMD>:windo diffthis<CR>" },
	{
		desc = "Diff: New split",
		cmd = function()
			vim.cmd([[enew]])
			require("nvim-tree.api").tree.close()
			vim.cmd([[vnew]])
			vim.cmd([[windo diffthis]])
		end,
	},
	{ desc = "Diff: Stop", cmd = "<CMD>:diffoff!<CR>" },
	-- {
	--     desc = "Sort descending",
	--     cmd = "<CMD>lua vim.cmd[[Sort!]<CR>]",
	-- },
})

function ShowMappingsInBuffer()
	vim.cmd([[redir @a | silent map | redir END | enew | put a]])
end

function CloseAllBuffers()
	for _, e in ipairs(require("bufferline").get_elements().elements) do
		if e ~= nil then
			vim.schedule(function()
				vim.cmd("bd " .. e.id)
			end)
		end
	end
end

function CloseAllButCurrent()
	for _, e in ipairs(require("bufferline").get_elements().elements) do
		vim.schedule(function()
			if e.id == vim.api.nvim_get_current_buf() then
				return
			else
				vim.cmd("bd " .. e.id)
			end
		end)
	end
end

