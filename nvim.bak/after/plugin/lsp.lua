local lsp = require("lsp-zero")

lsp.preset("lsp-compe") -- Setting up nvim-cmp manually
-- lsp.preset('recommended')
lsp.set_preferences({})

lsp.ensure_installed({
	"tsserver",
	"eslint",
	-- "sumneko_lua",
	"lua_ls", -- Temporarily
	"rust_analyzer",
	"bashls",
	--'cpplint',
	--'cpptools',
	--'csharpier',
	--'cspell',
	"cssls",
	--'dockerfile-language-server',
	--'json-lsp',
	--'jsonlint',
	--'markdownlint',
	"omnisharp",
	"pyright",
	"vimls",
	"lemminx",
	"yamlls",
	"html",
	"zls",
	-- "ols"
})
--
-- vim.cmd[[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]]
-- vim.cmd[[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]]

-- local cmp = require 'cmp'
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<CR>'] = cmp.mapping.confirm({
--         -- behavior = cmp.ConfirmBehavior.Replace,
--         select = true,
--     }),
--     -- ['<C-Space>'] = cmp.mapping.complete(),
--     -- toggle completion
--     ['<C-Space>'] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--             cmp.abort()
--         else
--             cmp.complete()
--         end
--     end, { 'i', 's' }),
-- })
--

-- local has_words_before = function()
-- 	-- unpack = unpack or table.unpack
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--
-- lsp.setup_nvim_cmp({
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body)
-- 		end,
-- 	},
-- 	sources = {
-- 		{ name = "path" },
-- 		{ name = "nvim_lsp", keyword_length = 1 },
-- 		{ name = "buffer", keyword_length = 1 },
-- 		{ name = "luasnip" },
-- 	},
-- 	mapping = {
-- 		["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
-- 		["<C-f>"] = require("cmp").mapping.scroll_docs(4),
-- 		-- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
-- 		["<C-e>"] = require("cmp").mapping.abort(),
-- 		["<CR>"] = require("cmp").mapping.confirm({
-- 			-- behavior = cmp.ConfirmBehavior.Replace,
-- 			select = true,
-- 		}),
-- 		["<C-Space>"] = require("cmp").mapping(function(fallback)
-- 			if require("cmp").visible() then
-- 				require("cmp").abort()
-- 			else
-- 				require("cmp").complete()
-- 			end
-- 		end),
-- 		["<Tab>"] = require("cmp").mapping(function(fallback)
-- 			if require("cmp").visible() then
-- 				require("cmp").select_next_item()
-- 			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
-- 			-- they way you will only jump inside the snippet region
-- 			elseif require("luasnip").expand_or_jumpable() then
-- 				require("luasnip").expand_or_jump()
-- 			elseif has_words_before() then
-- 				require("cmp").complete()
-- 			else
-- 				local mode = vim.fn.mode()
-- 				if mode == "n" then
-- 					vim.api.nvim_feedkeys(">>", "n", false)
-- 				elseif mode == "v" then
-- 					vim.api.nvim_feedkeys(">gv", "v", false)
-- 				end
-- 				-- fallback()
-- 			end
-- 		end, { "i", "s" }),
--
-- 		["<S-Tab>"] = require("cmp").mapping(function(fallback)
-- 			if require("cmp").visible() then
-- 				require("cmp").select_prev_item()
-- 			elseif require("luasnip").jumpable(-1) then
-- 				require("luasnip").jump(-1)
-- 			else
-- 				local mode = vim.fn.mode()
-- 				if mode == "n" then
-- 					vim.api.nvim_feedkeys("<<", "n", false)
-- 				elseif mode == "v" then
-- 					vim.api.nvim_feedkeys("<gv", "v", false)
-- 				end
-- 				-- fallback()
-- 			end
-- 		end, { "i", "s" }),
-- 	},
-- })

-- vim.keymap.set("v", "<S-TAB>", "<gv") -- Indent right without losing visual selection
-- vim.keymap.set("v", "<TAB>", ">gv") -- Indent right without losing visual selection
-- vim.keymap.set("n", "<S-TAB>", "<<") -- Indent right without losing visual selection
-- vim.keymap.set("n", "<TAB>", ">>") -- Indent right without losing visual selection

-- require("zls").setup({})
-- require("ols").setup({})
require('lspconfig').ols.setup({})

require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			diagnostics = { globals = { "vim" } },
		}, -- Stop undefined 'vim' warnings
	},
})

lsp.configure("tailwindcss", {
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					"tailwind\\('([^)]*)\\')",
					"'([^']*)'",
				},
			},
		},
	},
})

-- https://github.com/neovim/nvim-lspconfig/blob/6b43ce561d97412cc512b569db6938e44529293e/doc/server_configurations.md#omnisharp
lsp.configure("omnisharp", {
	-- Enables support for reading code style, naming convention and analyzer
	-- settings from .editorconfig.
	enable_editorconfig_support = true,

	-- If true, MSBuild project system will only load projects for files that
	-- were opened in the editor. This setting is useful for big C# codebases
	-- and allows for faster initialization of code navigation features only
	-- for projects that are relevant to code that is being edited. With this
	-- setting enabled OmniSharp may load fewer projects and may thus display
	-- incomplete reference lists for symbols.
	enable_ms_build_load_projects_on_demand = false,

	-- Enables support for roslyn analyzers, code fixes and rulesets.
	enable_roslyn_analyzers = true,

	-- Specifies whether 'using' directives should be grouped and sorted during
	-- document formatting.
	organize_imports_on_format = true,

	-- Enables support for showing unimported types and unimported extension
	-- methods in completion lists. When committed, the appropriate using
	-- directive will be added at the top of the current file. This option can
	-- have a negative impact on initial completion responsiveness,
	-- particularly for the first few completion sessions after opening a
	-- solution.
	enable_import_completion = false,

	-- Specifies whether to include preview versions of the .NET SDK when
	-- determining which version to use for project loading.
	sdk_include_prereleases = true,

	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
	-- true
	analyze_open_documents_only = false,

	-- https://github.com/neovim/nvim-lspconfig/blob/dcb7ebb36f0d2aafcc640f520bb1fc8a9cc1f7c8/lua/lspconfig/server_configurations/omnisharp.lua
	on_new_config = function(new_config, new_root_dir)
		table.insert(new_config.cmd, "-z") -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
		vim.list_extend(new_config.cmd, { "-s", new_root_dir })
		vim.list_extend(new_config.cmd, { "--hostPID", tostring(vim.fn.getpid()) })
		table.insert(new_config.cmd, "DotNet:enablePackageRestore=true")
		vim.list_extend(new_config.cmd, { "--encoding", "utf-8" })
		table.insert(new_config.cmd, "--languageserver")

		if new_config.enable_editorconfig_support then
			table.insert(new_config.cmd, "FormattingOptions:EnableEditorConfigSupport=true")
		end

		if new_config.organize_imports_on_format then
			table.insert(new_config.cmd, "FormattingOptions:OrganizeImports=true")
		end

		if new_config.enable_ms_build_load_projects_on_demand then
			table.insert(new_config.cmd, "MsBuild:LoadProjectsOnDemand=true")
		end

		if new_config.enable_roslyn_analyzers then
			table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableAnalyzersSupport=true")
		end

		if new_config.enable_import_completion then
			table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableImportCompletion=true")
		end

		if new_config.sdk_include_prereleases then
			table.insert(new_config.cmd, "Sdk:IncludePrereleases=true")
		end

		if new_config.analyze_open_documents_only then
			table.insert(new_config.cmd, "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true")
		end
	end,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)lsp
	-- vim.lsp.buf.hover
	-- vim.lsp.buf.workspace_symbol
	-- vim.diagnostic.open_float
	-- vim.diagnostic.goto_next
	-- vim.lsp.buf.code_action
	-- vim.lsp.buf.references
	-- vim.lsp.buf.rename
	-- vim.lsp.buf.signature_help
	-------------------------- "Show" mappings
	vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float) -- [s]how [e]rror
	vim.keymap.set("n", "<leader>sE", vim.diagnostic.setloclist) -- [s]how all [E]rrors in file  alternative is telescope_builtin.diagnostics
	vim.keymap.set("n", "<leader>sm", vim.lsp.buf.signature_help) -- [s]how [m]ethod signature (VS like)
	vim.keymap.set("n", "<C-S-Space>", vim.lsp.buf.hover)  -- [s]how [m]ethod signature (VS like)

	-------------------------- "Go to" mappings
	vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next) -- [g]o to next [e]rror
	vim.keymap.set("n", "<C-S-F12>", function()          -- Go to next error/warning/info/hint
		if vim.diagnostic.get_next({ severity = vim.diagnostic.severity.ERROR }) then
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		elseif vim.diagnostic.get_next({ severity = vim.diagnostic.severity.WARN }) then
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
		elseif vim.diagnostic.get_next({ severity = vim.diagnostic.severity.INFO }) then
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
		elseif vim.diagnostic.get_next({ severity = vim.diagnostic.severity.HINT }) then
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
		end
	end)
	print("Language server started")
end)

vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action)
vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename) -- [c]ode [r]ename (VS like)
vim.keymap.set("n", "<leader>kd", vim.lsp.buf.format) -- [c]ode [f]ormat (VS like)
--vim.keymap.set("n", "<leader>kc", function() require'Comment.api'.toggle.linewise() end) -- Comment toggle (VS like)
--vim.keymap.set('x', '<leader>kc', function() -- Comment toggle (VS like)
--vim.api.nvim_feedkeys('<ESC>', 'nx', false)
--require'Comment.api'.toggle.linewise(vim.fn.visualmode())
--end)
--vim.keymap.set('v', '<leader>kc', "<Plug>(comment_toggle_linewise)")

vim.opt.signcolumn = "yes" -- Keep sign column always visible

lsp.setup()

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local has_words_before = function()
	-- unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_config = lsp.defaults.cmp_config({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer",   keyword_length = 1 },
		{ name = "luasnip" },
	},
	mapping = {
		["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
		["<C-f>"] = require("cmp").mapping.scroll_docs(4),
		-- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = require("cmp").mapping.abort(),
		["<CR>"] = require("cmp").mapping.confirm({
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-Space>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").abort()
			else
				require("cmp").complete()
			end
		end),
		["<Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
			elseif require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
				-- elseif has_words_before() then -- I use <C-Space> to open completion
				-- 	require("cmp").complete()
			else
				local mode = vim.fn.mode()
				if mode == "n" then -- Mappings are for "s" and "i" modes only, so this is unreachalbe, but left for reference
					vim.api.nvim_feedkeys(">>", "n", false)
				elseif mode == "v" then
					vim.api.nvim_feedkeys(">gv", "v", false)
				elseif mode == "i" then
					-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-t>", true, false, true), "i", true)
					-- else
					fallback()
				end
			end
		end, { "i", "s" }),
		["<S-Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				local mode = vim.fn.mode()
				if mode == "n" then -- Mappings are for "s" and "i" modes only, so this is unreachalbe, but left for reference
					vim.api.nvim_feedkeys("<<", "n", false)
				elseif mode == "v" then
					vim.api.nvim_feedkeys("<gv", "v", false)
				elseif mode == "i" then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true),
						"i", true)
				else
					fallback()
				end
			end
		end, { "i", "s" }),
	},
})

require("cmp").setup(cmp_config)

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Javascript / Typescript
-- use 'jose-elias-alvarez/null-ls.nvim' -- Use eslint and prettier
-- use 'jose-elias-alvarez/nvim-lsp-ts-utils' -- Provides some VSCode like features with import, etc.?
lsp.configure("tsserver", {
	-- on_attach = require'lsp.servers.tsserver'.on_attach,
	capabilities = capabilities,
})
