if vim.g.did_load_lazygit_plugin then
	return
end
vim.g.did_load_lazygit_plugin = true

require("telescope").load_extension("lazygit")

vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = '[git] openlazygit', silent = true })
