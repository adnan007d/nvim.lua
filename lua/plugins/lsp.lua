return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			{ "williamboman/mason-lspconfig.nvim" },

			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},

			-- Autocompletion
			-- {
			-- 	"hrsh7th/nvim-cmp",
			-- 	opts = function(_, opts)
			-- 		opts.sources = opts.sources or {}
			-- 		table.insert(opts.sources, {
			-- 			name = "lazydev",
			-- 			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			-- 		})
			-- 	end,
			-- },
			-- { "hrsh7th/cmp-buffer" },
			-- { "hrsh7th/cmp-path" },
			-- { "saadparwaiz1/cmp_luasnip" },
			-- { "hrsh7th/cmp-nvim-lsp" },
			-- { "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")

			local servers = {
				"lua_ls",
				-- "ts_ls",
				"eslint",
				"emmet_ls",
				"tailwindcss",
				"svelte",
				"jsonls",
				"yamlls",
			}
			local lsp_util = require("config.lsp.util")
			mason_lspconfig.setup({
				ensure_installed = servers,
			})
			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = lsp_util.capabilities,
						on_attach = lsp_util.on_attach,
					})
				end,
				lua_ls = require("config.lsp.lua_ls"),
				gopls = require("config.lsp.gopls"),
				ts_ls = require("config.lsp.ts_ls"),
				tailwindcss = require("config.lsp.tailwindcss"),
				emmet_ls = require("config.lsp.emmet_ls"),
				jsonls = require("config.lsp.jsonls"),
				yamlls = require("config.lsp.yamlls"),
				ruff = require("config.lsp.ruff"),
				pylsp = require("config.lsp.pylsp"),
			})

			-- local cmp = require("cmp")
			-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			-- cmp.setup({
			-- 	window = {
			-- 		completion = cmp.config.window.bordered(),
			-- 		documentation = cmp.config.window.bordered(),
			-- 	},
			-- 	snippet = {
			-- 		expand = function(args)
			-- 			luasnip.lsp_expand(args.body)
			-- 		end,
			-- 	},
			-- 	mapping = cmp.mapping.preset.insert({
			-- 		["<C-b>"] = cmp.mapping.scroll_docs(-4),
			-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
			-- 		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			-- 		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			-- 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
			-- 		["<C-Space>"] = cmp.mapping.complete(),
			-- 		["<C-q>"] = cmp.mapping.complete(),
			-- 		-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
			-- 		-- Use <Tab> and <Shift-Tab> to navigate through snippet placeholders
			-- 		["<Tab>"] = cmp.mapping(function(fallback)
			-- 			if luasnip.jumpable(1) then
			-- 				luasnip.jump(1) -- Jump to the next placeholder
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "i", "s" }),
			--
			-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 			if luasnip.jumpable(-1) then
			-- 				luasnip.jump(-1) -- Jump to the previous placeholder
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "i", "s" }),
			-- 	}),
			-- 	sources = {
			-- 		{ name = "nvim_lsp" },
			-- 		{ name = "luasnip" },
			-- 		{ name = "buffer" },
			-- 		{ name = "path" },
			-- 		{ name = "nvim_lua" },
			-- 	},
			-- })

			-- -- these borders doesn't work in nvim 0.11
			-- vim.lsp.buf.hover({
			-- 	border = "rounded",
			-- })
			--
			-- vim.lsp.buf.signature_help({
			-- 	border = "rounded",
			-- })

			local _open_floating_preview = vim.lsp.util.open_floating_preview
			vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				return _open_floating_preview(contents, syntax, opts, ...)
			end

			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
			})
		end,
	},
}
