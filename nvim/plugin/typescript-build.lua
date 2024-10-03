if vim.g.did_load_typescript_build_plugin then
	return
end
vim.g.did_load_typescript_build_plugin = true

local function parse_tsc_output(output)
	local qf_entries = {}
	for line in output:gmatch("[^\r\n]+") do
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
	return qf_entries
end

local function typescript_build()
	-- Clear the quickfix list
	vim.fn.setqflist({}, 'r')

	-- Notify user that build has started
	vim.notify("TypeScript build started...", vim.log.levels.INFO)

	local output = ""
	local job_id = vim.fn.jobstart('tsc --noEmit', {
		on_stdout = function(_, data)
			output = output .. table.concat(data, "\n")
		end,
		on_stderr = function(_, data)
			output = output .. table.concat(data, "\n")
		end,
		on_exit = function(_, exit_code)
			local qf_entries = parse_tsc_output(output)
			vim.fn.setqflist(qf_entries)

			if exit_code == 0 and #qf_entries == 0 then
				vim.notify("TypeScript build successful!", vim.log.levels.INFO)
			else
				vim.notify("TypeScript build completed with errors. Check quickfix list.", vim.log.levels.WARN)
				vim.cmd('copen')
			end
		end
	})

	if job_id == 0 then
		vim.notify("Failed to start TypeScript build job", vim.log.levels.ERROR)
	elseif job_id == -1 then
		vim.notify("Invalid TypeScript build command", vim.log.levels.ERROR)
	end
end

-- Create a user command to run the TypeScript build
vim.api.nvim_create_user_command('TypeScriptBuild', typescript_build, {})
