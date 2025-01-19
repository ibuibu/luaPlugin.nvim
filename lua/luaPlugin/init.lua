local function hoge()
	local url = unpack(vim.fn.systemlist("git remote get-url origin"))
	url = url:gsub("ssh", "https")
	url = url:sub(1, -5)

	local commit_hash = unpack(vim.fn.systemlist("git show -s --format=%H"))

	local root_path = unpack(vim.fn.systemlist("git rev-parse --show-toplevel"))
	local root_path_len = #root_path
	local cur_path = vim.api.nvim_buf_get_name(0)
	local file_path = cur_path:sub(root_path_len + 1)

	local mode = vim.fn.mode()

	local line
	if mode == "V" then
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.getcurpos("v")[2]
		line = start_line .. "-" .. end_line
		vim.api.nvim_input("<esc>")
	else
		line, _ = unpack(vim.api.nvim_win_get_cursor(0))
	end

	local target_url = url .. "/blob/" .. commit_hash .. file_path .. "#L" .. line

	vim.fn.setreg("*", target_url)
	print("copied! " .. target_url)
end

return {
	hoge = hoge,
}
