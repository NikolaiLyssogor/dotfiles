local M = {}

--- @param filepath string
function M.read_file_first_line(filepath)
  local file = io.open(filepath, "r")
  if not file then
    error("Could not open file: " .. filepath)
  end
  local line = file:read("*line")
  file:close()
  return line
end

--- @param filename string
--- @return string
function M.gpg_secret_cmd(filename)
  local filepath = os.getenv("HOME") .. "/Documents/secrets/" .. filename
  return 'cmd:gpg --decrypt --batch --passphrase " " ' .. filepath .. ' 2>/dev/null'
end

return M
