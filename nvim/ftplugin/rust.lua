-- ~/.config/nvim/lua/plugins/lsp/rust.lua
print("--- Loading Rust LSP config file ---") -- Add this line

local lspconfig = require('lspconfig')

-- Check if we're in a devenv environment
local function is_in_devenv()
	-- Add a print inside here too for debugging
	local devenv_root = os.getenv("DEVENV_ROOT")
	print("Checking for DEVENV_ROOT: ", devenv_root)
	return devenv_root ~= nil
end

-- Setup rust-analyzer only if we're in devenv
if is_in_devenv() then
	print("Devenv detected. Setting up rust-analyzer...") -- This is your original print

	lspconfig.rust_analyzer.setup {
		-- ... rest of your setup ...
	}

	-- Rust-specific keymaps and settings via autocommand
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "rust",
		callback = function()
			print("--- Rust FileType Autocommand Triggered ---") -- Add print here
			-- ... rest of your autocommand ...
		end,
	})
else
	print("Not in devenv. Rust-specific configurations are not loaded.")
end

print("--- Finished loading Rust LSP config file ---") -- Add this line

