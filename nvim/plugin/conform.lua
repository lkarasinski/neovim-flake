if vim.g.did_load_conform_plugin then
	return
end
vim.g.did_load_conform_plugin = true

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		typescriptreact = { 'biome-check' },
		javascriptreact = { 'biome-check' },
		typescript = { 'biome-check' },
		javascript = { 'biome-check' },
		json = { 'biome-check' },
		nix = { "alejandra" }
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
