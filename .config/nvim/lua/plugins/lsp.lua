return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		opts = {
			servers = {
				buf_ls = {},
				cue = {},
				cssls = {
					settings = {
						css = { lint = { unknownAtRules = "ignore" } },
						scss = { lint = { unknownAtRules = "ignore" } },
						less = { lint = { unknownAtRules = "ignore" } },
					},
				},
				ember = {},
				sqlformat = {
					filetypes = { "sql" },
				},
				vtsls = {
					settings = {
						typescript = {
							inlayHints = {
								parameterNames = { enabled = "none" },
								parameterTypes = { enabled = false },
								variableTypes = { enabled = false },
								propertyDeclarationTypes = { enabled = false },
								functionLikeReturnTypes = { enabled = false },
								enumMemberValues = { enabled = false },
							},
						},
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "none" },
								parameterTypes = { enabled = false },
								variableTypes = { enabled = false },
								propertyDeclarationTypes = { enabled = false },
								functionLikeReturnTypes = { enabled = false },
								enumMemberValues = { enabled = false },
							},
						},
					},
				},
				eslint = {
					settings = {
						eslint = {
							trace = { server = "messages" }, -- log from the eslint server
						},
					},
				},
			},
		},
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
