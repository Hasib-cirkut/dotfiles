vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-d>"]], { expr = true, noremap = true })

vim.wo.number = true

vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes:2"

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")

vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bb", ":bprev<CR>")
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>")

-- Customize diagnostic display
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be '■', '▎', 'x'
		spacing = 4,
		source = "if_many",
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
	float = {
		source = "always",
		border = "rounded",
		style = "minimal",
		header = "",
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float)

-- Wrapper function for vim.lsp.buf.hover() to handle long messages
local function hover_wrapper()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
		if result and result.contents then
			local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
			local opts = {
				max_width = 80,
				max_height = math.floor(vim.o.lines * 0.5),
				wrap_at = 80,
				border = "rounded",
			}
			vim.lsp.util.open_floating_preview(markdown_lines, "markdown", opts)
		else
			vim.lsp.buf.hover()
		end
	end)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
