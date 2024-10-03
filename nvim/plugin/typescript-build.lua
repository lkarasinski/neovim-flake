if vim.g.did_load_typescript_build_plugin then
	return
end
vim.g.did_load_typescript_build_plugin = true

local function typescript_build()
	-- Clear the quickfix list
	vim.fn.setqflist({}, 'r')

	-- Run tsc and capture the output
	local output = vim.fn.system('tsc --noEmit')

	-- Parse the output and populate the quickfix list
	local lines = vim.split(output, '\n')
	local qf_entries = {}
	for _, line in ipairs(lines) do
		local file, lnum, col, type, msg = line:match("(.+)%((%d+),(%d+)%): (%a+) TS%d+: (.+)")
		if file then
			table.insert(qf_entries, {
				filename = file,
				lnum = tonumber(lnum),
				col = tonumber(col),
				type = type:sub(1, 1):upper(),
				text = msg
			})
		end
	end

	-- Set the quickfix list with the parsed entries
	vim.fn.setqflist(qf_entries)

	-- Open the quickfix list if there are errors
	if #qf_entries > 0 then
		vim.cmd('copen')
	else
		print("TypeScript build successful!")
	end
end

-- Create a user command to run the TypeScript build
vim.api.nvim_create_user_command('TypeScriptBuild', typescript_build, {})
