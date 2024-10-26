if vim.fn.executable('nixd') ~= 1 then
	return
end

local root_files = {
	'flake.nix',
	'default.nix',
	'shell.nix',
	'configuration.nix',
	'.git',
}

vim.lsp.start {
	name = 'nixd',
	cmd = { 'nixd' },
	root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
	capabilities = require('user.lsp').make_client_capabilities(),
	settings = {
		nixd = {
			formatting = {
				command = "alejandra"
			},
			options = {
				enable = true,
				target = {
					args = {},
					installable = "<flake>#nixosConfigurations.nixos.config", -- Adjust this to match your flake output
				},
			},
			eval = {
				enable = true,
				workers = 3,
			},
		}
	},
	on_attach = function(client, bufnr)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Show module option documentation' })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to module option definition' })

		vim.keymap.set('n', '<leader>no', function()
			require('telescope.builtin').lsp_workspace_symbols({ query = '' })
		end, { buffer = bufnr, desc = 'Search NixOS module options' })
	end,
}

local has_cmp, cmp = pcall(require, 'cmp')
if has_cmp then
	cmp.setup.filetype('nix', {
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
		})
	})
end
