local function hoge()
  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  print('cursor', r, c)

  local result = vim.fn.systemlist('git config --get remote.origin.url')
  for k, v in pairs(result) do
    print(k, v)
  end

  -- local aa = vim.fn.expand("%:p")
  -- print(aa)

  local bb = vim.api.nvim_buf_get_name(0)
  print(bb)
end

return {
  hoge = hoge
}
