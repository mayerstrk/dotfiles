-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end

		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang and pcall(vim.treesitter.language.inspect, lang) then
			pcall(vim.treesitter.start)
		end
	end,
})
