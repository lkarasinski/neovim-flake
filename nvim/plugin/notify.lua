if vim.g.did_load_notify_plugin then
	return
end
vim.g.did_load_notify_plugin = true

local notify = require('notify')

notify.setup({
	fps = 165,
})

vim.notify = notify
