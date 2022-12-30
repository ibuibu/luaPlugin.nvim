local function gitLine()

  local url = unpack(vim.fn.systemlist('git config --get remote.origin.url'))
  url = url:gsub("github.com:", "github.com/")
  url = url:gsub("git@", "https://")
  url = url:sub(1, -5)

  local commit_hash = unpack(vim.fn.systemlist('git show -s --format=%H'))

  local root_path = unpack(vim.fn.systemlist('git rev-parse --show-toplevel'))
  local cur_path = vim.api.nvim_buf_get_name(0)
  local file_path = cur_path:gsub(root_path, "")

  local cur_line, _ = unpack(vim.api.nvim_win_get_cursor(0))

  -- local visual_first_line = vim.api.nvim_buf_get_mark(0, "<")[1]
  -- local visual_last_line = vim.api.nvim_buf_get_mark(0, ">")[1]
  -- print(visual_first_line, visual_last_line)

  local target_url = url .. "/blob/" .. commit_hash .. file_path .. "#L" .. cur_line

  vim.fn.setreg('*', target_url)
  print("copied!")
end

return {
  gitLine = gitLine
}
