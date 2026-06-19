return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			opts = opts or {}
			opts.routes = opts.routes or {}
			opts.commands = opts.commands or {}
			opts.presets = opts.presets or {}
			opts.cmdline = opts.cmdline or {}
			opts.popupmenu = opts.popupmenu or {}

			opts.cmdline.enabled = true
			opts.cmdline.view = "cmdline"
			opts.popupmenu.enabled = false

			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			local focused = true

			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})

			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})

			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands.all = {
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						local ok, markdown = pcall(require, "noice.text.markdown")
						if ok then
							markdown.keys(event.buf)
						end
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
		},
		keys = {},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
███╗   ███╗███████╗████████╗ █████╗ ██████╗ ██╗  ██╗
████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██║ ██╔╝
██╔████╔██║███████╗   ██║   ███████║██████╔╝█████╔╝ 
██║╚██╔╝██║╚════██║   ██║   ██╔══██║██╔══██╗██╔═██╗ 
██║ ╚═╝ ██║███████║   ██║   ██║  ██║██║  ██║██║  ██╗
╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
                                                    
   ]],
				},
			},
		},

		config = function(_, opts)
			require("snacks").setup(opts)
			-- local accent = "#f38ba8" -- warm pink-orange tone
			-- vim.api.nvim_set_hl(0, "SnacksDashboard", { fg = accent, bold = true })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = accent, bold = true })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = accent, italic = true })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = accent, bold = true })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardNormal", { fg = accent })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = accent })
			-- vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = accent })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (can be toggled with commands)
				throttle = true, -- Throttles plugin updates (improves performance)
				max_lines = 2, -- Unlimited
				patterns = {
					-- Match patterns for all file types
					default = {
						"class",
						"function",
						"method",
					},
				},
			})

			-- Set custom highlight colors
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2E3440", fg = "#ECEFF4" })
			vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "#2E3440", fg = "#88C0D0" })
		end,
	},
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	version = false,
	-- 	enable = true,
	--
	-- 	config = function(_, opts)
	-- 		require("mini.animate").setup()
	-- 	end,
	-- },
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 200, -- milliseconds before blame appears (default is 400)
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		},
	},
}
