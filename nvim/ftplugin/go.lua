local lspconfig = require('lspconfig')

-- Check if we're in a devenv environment
local function is_in_devenv()
	return os.getenv("DEVENV_ROOT") ~= nil
end

-- Setup gopls only if we're in devenv
if is_in_devenv() then
	lspconfig.gopls.setup {
		cmd = { 'gopls' },
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
			},
		},
	}

	-- Go-specific keymaps
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		callback = function()
			-- Run gofmt on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					vim.lsp.buf.format()
				end,
			})

			-- Keybindings
			local opts = { noremap = true, silent = true, buffer = true }
			vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
			vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
			vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		end,
	})
else
	print("Not in devenv. Go-specific configurations are not loaded.")
end
