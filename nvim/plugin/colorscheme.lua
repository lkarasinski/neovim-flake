if vim.g.did_load_colorscheme_plugin then
	return
end
vim.g.did_load_colorscheme_plugin = true

require('kanagawa').setup({
	compile = false,
	undercurl = true,
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	colors = {
		palette = {
			dragonBlack3 = "#000000",
		},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},
	overrides = function(colors)
		return {}
	end,
	theme = "dragon",
	background = {
		dark = "dragon",
		light = "lotus"
	},
})

vim.cmd("colorscheme kanagawa")
