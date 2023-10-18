-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = false,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
			-- add any global capabilities here
			capabilities = {},
			-- Automatically format on save
			autoformat = true,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				-- csharp_ls = {
				-- 	on_attach = function(client, bufnr)
				-- 		client.server_capabilities.semanticTokensProvider = nil
				-- 	end
				-- },
				-- omnisharp = {
				-- 	-- Enables support for reading code style, naming convention and analyzer
				-- 	-- settings from .editorconfig.
				-- 	enable_editorconfig_support = true,
				--
				-- 	-- If true, MSBuild project system will only load projects for files that
				-- 	-- were opened in the editor. This setting is useful for big C# codebases
				-- 	-- and allows for faster initialization of code navigation features only
				-- 	-- for projects that are relevant to code that is being edited. With this
				-- 	-- setting enabled OmniSharp may load fewer projects and may thus display
				-- 	-- incomplete reference lists for symbols.
				-- 	enable_ms_build_load_projects_on_demand = false,
				--
				-- 	-- Enables support for roslyn analyzers, code fixes and rulesets.
				-- 	enable_roslyn_analyzers = true,
				--
				-- 	-- Specifies whether 'using' directives should be grouped and sorted during
				-- 	-- document formatting.
				-- 	organize_imports_on_format = true,
				--
				-- 	-- Enables support for showing unimported types and unimported extension
				-- 	-- methods in completion lists. When committed, the appropriate using
				-- 	-- directive will be added at the top of the current file. This option can
				-- 	-- have a negative impact on initial completion responsiveness,
				-- 	-- particularly for the first few completion sessions after opening a
				-- 	-- solution.
				-- 	enable_import_completion = false,
				--
				-- 	-- Specifies whether to include preview versions of the .NET SDK when
				-- 	-- determining which version to use for project loading.
				-- 	sdk_include_prereleases = true,
				--
				-- 	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
				-- 	-- true
				-- 	analyze_open_documents_only = false,
				--
				-- 	-- https://github.com/neovim/nvim-lspconfig/blob/dcb7ebb36f0d2aafcc640f520bb1fc8a9cc1f7c8/lua/lspconfig/server_configurations/omnisharp.lua
				-- 	on_new_config = function(new_config, new_root_dir)
				-- 		table.insert(new_config.cmd, "-z") -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
				-- 		vim.list_extend(new_config.cmd, { "-s", new_root_dir })
				-- 		vim.list_extend(new_config.cmd,
				-- 			{ "--hostPID", tostring(vim.fn.getpid()) })
				-- 		table.insert(new_config.cmd, "DotNet:enablePackageRestore=true")
				-- 		vim.list_extend(new_config.cmd, { "--encoding", "utf-8" })
				-- 		table.insert(new_config.cmd, "--languageserver")
				--
				-- 		if new_config.enable_editorconfig_support then
				-- 			table.insert(new_config.cmd,
				-- 				"FormattingOptions:EnableEditorConfigSupport=true")
				-- 		end
				--
				-- 		if new_config.organize_imports_on_format then
				-- 			table.insert(new_config.cmd,
				-- 				"FormattingOptions:OrganizeImports=true")
				-- 		end
				--
				-- 		if new_config.enable_ms_build_load_projects_on_demand then
				-- 			table.insert(new_config.cmd, "MsBuild:LoadProjectsOnDemand=true")
				-- 		end
				--
				-- 		if new_config.enable_roslyn_analyzers then
				-- 			table.insert(new_config.cmd,
				-- 				"RoslynExtensionsOptions:EnableAnalyzersSupport=true")
				-- 		end
				--
				-- 		if new_config.enable_import_completion then
				-- 			table.insert(new_config.cmd,
				-- 				"RoslynExtensionsOptions:EnableImportCompletion=true")
				-- 		end
				--
				-- 		if new_config.sdk_include_prereleases then
				-- 			table.insert(new_config.cmd, "Sdk:IncludePrereleases=true")
				-- 		end
				--
				-- 		if new_config.analyze_open_documents_only then
				-- 			table.insert(new_config.cmd,
				-- 				"RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true")
				-- 		end
				-- 	end,
				-- },
				jsonls = {},
				lua_ls = {
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
							client.config.settings = vim.tbl_deep_extend('force',
								client.config.settings.Lua, {
									diagnostics = {
										-- Get the language server to recognize the `vim` global
										globals = {
											-- 'vim'
										},
									},
									runtime = {
										-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
										version = 'LuaJIT'
									},
									-- Make the server aware of Neovim runtime files
									workspace = {
										--library = { vim.env.VIMRUNTIME }
										-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
										library = vim.api.nvim_get_runtime_file(
											"", true)
									},
									telemetry = {
										enable = false,
									},
								})

							client.notify("workspace/didChangeConfiguration",
								{ settings = client.config.settings })
						end
						return true
					end
				},
				html = {
				},
				zls = {
				}
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				jsonls = function(_, opts)
					require 'lspconfig'.jsonls.setup(opts)
				end,
				lua_ls = function(_, opts)
					require 'lspconfig'.lua_ls.setup(opts)
				end,
				-- csharp_ls = function(_, opts)
				-- 	require 'lspconfig'.csharp_ls.setup(opts)
				-- end,
				-- omnisharp = function(_, opts)
				-- 	require 'lspconfig'.omnisharp.setup(opts)
				-- end,
				html = function(_, opts)
					--Enable (broadcasting) snippet capability for completion
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true

					require 'lspconfig'.html.setup {
						capabilities = capabilities,
					}
				end,
				zls = function(_, opts)
					-- Download latest from https://zig.pm/zls/downloads/aarch64-macos/bin/zls
					require 'lspconfig'.zls.setup {}
				end,
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},

		config = function(_, opts)
			require("neodev").setup({
				-- Always add neovim plugins into lua_ls library, for any lua files (even if they are not nvim configs)
				-- see also: neodev.lsp.on_new_config(...), folke/neodev.nvim#158
				override = function(root_dir, library)
					-- if string.find(root_dir, dotfiles_path, 1, true) then
					library.enabled = true
					library.plugins = true
					-- end
				end,
				lspconfig = true,
				pathStrict = true,
			})
			require 'utils'.on_lsp_attach(function(client, buffer)
				if
				    client.config
				    and client.config.capabilities
				    and client.config.capabilities.documentFormattingProvider == false
				then
					return
				end

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
						buffer = buffer,
						callback = function()
							if true then -- This can have a runtime-configured auto format option
								vim.lsp.buf.format { async = false }
							end
						end,
					})
				end
			end)

			-- Signs
			-- https://www.nerdfonts.com/cheat-sheet
			local signs = {
				Error = '',
				Warn = '',
				Info = '',
				Hint = '',
			}
			for type, icon in pairs(signs) do
				local hl = 'DiagnosticSign' .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				signs = true,
				update_in_insert = false,
				underline = false,
				severity_sort = true,
				virtual_text = {
					source = true,
				},
			})

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
			local servers = opts.servers

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server")
					.lspconfig_to_package)
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
