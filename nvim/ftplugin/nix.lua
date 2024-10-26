local lspconfig = require('lspconfig')

if vim.fn.executable('nixd') ~= 1 then
	return
end

lspconfig.nixd.setup({
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nixos.options',
				},
				home_manager = {
					expr =
					'(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."lkarasinski@nixos".options',
				},
			},
		},
	},
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	on_attach = function(client, bufnr)
		vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	end,
})
