local M = {}

-- Default config
local config = {
	keybind = "<leader>.",
	insert_keybind = "<leader>,",
	symbol = "|>",
	filetypes = { "gleam", "elm", "elixir", "fsharp", "ocaml", "reason" },
	auto_insert = true,
}

-- Setup function for user config
M.setup = function(user_config)
	config = vim.tbl_deep_extend("force", config, user_config or {})
	vim.keymap.set({ "n", "v" }, config.keybind, M.insert_at_start, { desc = "Add lil guy pipe at start of line" })
	vim.keymap.set({ "n" }, config.insert_keybind, M.insert_at_cursor, { desc = "Add lil guy pipe at cursor" })
end

M.check_filetype = function()
	local current_ft = vim.bo.filetype
	if #config.filetypes > 0 and not vim.tbl_contains(config.filetypes, current_ft) then
		vim.notify("no lil guys for file type '" .. current_ft .. "'", vim.log.levels.DEBUG)
		return false
	else
		return true
	end
end

M.insert_at_start = function()
	-- Check filetype
	if not M.check_filetype() then
		return
	end

	-- Determine the selected line range
	local start_line = vim.fn.line(".")
	local count = vim.v.count
	local end_line

	if count > 0 and vim.fn.mode() == "n" then
		end_line = start_line + count - 1
	else
		end_line = vim.fn.line("v")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
	end

	-- flip orientation if selection is going up

	for line_num = start_line, end_line do
		guy_added = false
		local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

		if line ~= nil then
			local indent, rest = line:match("^(%s*)(.*)")

			local escaped = vim.pesc(config.symbol)
			if rest:find("^" .. escaped .. "%s*") then
				rest = rest:gsub("^" .. escaped .. "%s*", "")
				line = indent .. rest
			else
				line = indent .. config.symbol .. " " .. rest
				if rest == "" then
					guy_added = true
				end
			end

			vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { line })
		end
	end

	-- jump into insert if we just threw a guy into a blank line
	if vim.fn.mode() == "n" and config.auto_insert and guy_added then
		vim.api.nvim_input("$i")
	end

	if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
		vim.api.nvim_input("<Esc>")
	end
end

M.insert_at_cursor = function()
	local escaped = vim.pesc(config.symbol)

	if not M.check_filetype() then
		return
	end

	if vim.fn.mode() == "n" then
		vim.api.nvim_input("i" .. escaped .. "<Space><Esc>l")
		-- if config.auto_insert then
		--   vim.api.nvim_input 'i'
		-- end
	end
end

return M
