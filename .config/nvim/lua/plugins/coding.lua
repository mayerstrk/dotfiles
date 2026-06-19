return {
	-- Create annotations with one keybind, and jump your cursor in the inserted annotation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- Go forward/backward with square brackets
	{
		"nvim-mini/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				cue_fmt = {
					command = "cue",
					args = { "fmt", "$FILENAME" },
					stdin = false,
				},
				prettier = {
					condition = function(_, ctx)
						local package_json = vim.fs.find("package.json", { path = ctx.dirname, upward = true })[1]
						if not package_json then
							return false
						end
						local content = table.concat(vim.fn.readfile(package_json), "\n")
						return content:find('"prettier"') ~= nil
					end,
				},
			},
			formatters_by_ft = {
				cue = { "cue_fmt" },
				handlebars = { "prettier" },
				python = { "black" },
				javascript = { "prettier", "eslint_d", stop_after_first = true },
				typescript = { "prettier", "eslint_d", stop_after_first = true },
				javascriptreact = { "prettier", "eslint_d", stop_after_first = true },
				typescriptreact = { "prettier", "eslint_d", stop_after_first = true },
			},
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
}
