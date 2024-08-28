if vim.g.did_load_neotree_plugin then
	return
end
vim.g.did_load_neotree_plugin = true

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true
		},
		follow_current_file = true,
	}
})
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.keymap.set('n', '<space>o', ':Neotree toggle<CR>', { desc = '[neo-tree] toggle file explorer', silent = true })
vim.keymap.set('n', '<space>e', ':Neotree focus<CR>', { desc = '[neo-tree] focus file explorer', silent = true })
