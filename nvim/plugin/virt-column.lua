if vim.g.did_load_virtcolumn_plugin then
	return
end
vim.g.did_load_virtcolumn_plugin = true

require("virt-column").setup({
	char = { "┆", "" },
	virtcolumn = "80",
})
