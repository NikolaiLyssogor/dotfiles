local M = {}

-- quickly make code block
--- @param lang string
local insert_code_chunk = function(lang)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	local keys
	keys = [[o```]] .. lang .. [[<cr>```<esc>O]]
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

function M.insert_py_chunk()
	insert_code_chunk("python")
end

function M.insert_cpp_chunk()
	insert_code_chunk("cpp")
end

function M.insert_js_chunk()
	insert_code_chunk("javascript")
end

function M.insert_lua_chunk()
	insert_code_chunk("lua")
end

function M.insert_bash_chunk()
	insert_code_chunk("bash")
end

function M.get_vault_path()
	local neovim_env = os.getenv("NEOVIM_ENV")
	local home_path = os.getenv("HOME")

	if neovim_env == "home" then
		return home_path .. "/Library/Mobile Documents/iCloud~md~obsidian"
	elseif neovim_env == "work" then
		return home_path .. "/Documents/notes"
	else
		print("Invalid env " .. neovim_env .. " passed to get_vault_path")
		return nil
	end
end

return M
