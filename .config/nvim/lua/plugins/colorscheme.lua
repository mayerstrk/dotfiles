return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- VertSplit = { fg = "muted", bg = "muted" },
					NormalFloat = { bg = "none" },
				},
			})
		end,
	},
	{ "ellisonleao/gruvbox.nvim" },
	{
		"catppuccin",
		opts = {
			transparent_background = true,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.cmd("highlight LineNr guifg=#8B8AA1")
					-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
					-- vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
					-- vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
					-- vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
				end,
			})
		end,
	},
	{ "whatyouhide/vim-gotham" },
}
