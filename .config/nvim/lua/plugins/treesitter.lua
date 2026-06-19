return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"astro",
				"cmake",
				"cpp",
				"cue",
				"css",
				"fish",
				"gitignore",
				"glimmer",
				"go",
				"graphql",
				"html",
				"http",
				"java",
				"php",
				"rust",
				"scss",
				"sql",
				"svelte",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "handlebars",
				callback = function(args)
					vim.treesitter.language.register("html", "handlebars")
					pcall(vim.treesitter.start, args.buf, "html")
				end,
			})
		end,
	},
}
