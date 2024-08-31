if vim.g.did_load_avante_plugin then
	return
end
vim.g.did_load_avante_plugin = true

require("avante").setup({})
