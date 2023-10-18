return {
	{
		"hrsh7th/nvim-cmp",
		config = function(_, opts)
			require("cmp").setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = require 'cmp'.mapping.preset.insert({
					['<C-b>'] = require 'cmp'.mapping.scroll_docs(-4),
					['<C-f>'] = require 'cmp'.mapping.scroll_docs(4),
					['<C-Space>'] = require 'cmp'.mapping.complete(),
					['<C-e>'] = require 'cmp'.mapping.abort(),
					['<CR>'] = require 'cmp'.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = require 'cmp'.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
				})
			})
		end,
	},
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "onsails/lspkind-nvim" },
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
	{ "tamago324/cmp-zsh" },
	--hrsh7th/cmp-cmdline
}
