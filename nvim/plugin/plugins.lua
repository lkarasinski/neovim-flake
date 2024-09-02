if vim.g.did_load_plugins_plugin then
	return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs
require('mini.surround').setup()
require('mini.cursorword').setup()
require("img-clip").setup({})
require("dressing").setup({})
