if vim.g.did_load_notify_plugin then
	return
end
vim.g.did_load_notify_plugin = true

require('notify').setup({
	fps = 165,
})
