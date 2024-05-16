local M = {}

-- local is_code_chunk = function()
-- 	local current, _ = require("otter.keeper").get_current_language_context()
-- 	if current then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

-- quickly make code block
--- @param lang string
local insert_code_chunk = function(lang)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	local keys
	-- if is_code_chunk() then
	-- 	keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
	-- else
	-- 	keys = [[o```]] .. lang .. [[<cr>```<esc>O]]
	-- end
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

function M.get_codecompanion_opts()
	local neovim_env = os.getenv("NEOVIM_ENV")
	if neovim_env == "home" then
		return {
			name = "openai",
			env = {
				api_key = 'cmd:gpg --decrypt --batch --passphrase " " /Users/nlyssogor/Documents/.openai_key.txt.gpg 2>/dev/null',
			},
      parameters = {
        stream = false,
      },
			schema = {
				model = {
					order = 1,
					mapping = "parameters",
					type = "enum",
					desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
					default = "gpt-4-turbo-2024-04-09",

					choices = {
						"gpt-4-0125-preview",
						"gpt-4-turbo-2024-04-09",
						"gpt-3.5-turbo-1106",
					},
				},
				temperature = {
					order = 2,
					mapping = "parameters",
					type = "number",
					optional = true,
					default = 1,
					desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
					validate = function(n)
						return n >= 0 and n <= 2, "Must be between 0 and 2"
					end,
				},
				top_p = {
					order = 3,
					mapping = "parameters",
					type = "number",
					optional = true,
					default = 1,
					desc = "An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both.",
					validate = function(n)
						return n >= 0 and n <= 1, "Must be between 0 and 1"
					end,
				},
				stop = {
					order = 4,
					mapping = "parameters",
					type = "list",
					optional = true,
					default = nil,
					subtype = {
						type = "string",
					},
					desc = "Up to 4 sequences where the API will stop generating further tokens.",
					validate = function(l)
						return #l >= 1 and #l <= 4, "Must have between 1 and 4 elements"
					end,
				},
				max_tokens = {
					order = 5,
					mapping = "parameters",
					type = "integer",
					optional = true,
					default = nil,
					desc = "The maximum number of tokens to generate in the chat completion. The total length of input tokens and generated tokens is limited by the model's context length.",
					validate = function(n)
						return n > 0, "Must be greater than 0"
					end,
				},
				presence_penalty = {
					order = 6,
					mapping = "parameters",
					type = "number",
					optional = true,
					default = 0,
					desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.",
					validate = function(n)
						return n >= -2 and n <= 2, "Must be between -2 and 2"
					end,
				},
				frequency_penalty = {
					order = 7,
					mapping = "parameters",
					type = "number",
					optional = true,
					default = 0,
					desc = "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.",
					validate = function(n)
						return n >= -2 and n <= 2, "Must be between -2 and 2"
					end,
				},
			-- 	logit_bias = {
			-- 		order = 8,
			-- 		mapping = "parameters",
			-- 		type = "map",
			-- 		optional = true,
			-- 		default = nil,
			-- 		desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
			-- 		subtype_key = {
			-- 			type = "integer",
			-- 		},
			-- 		subtype = {
			-- 			type = "integer",
			-- 			validate = function(n)
			-- 				return n >= -100 and n <= 100, "Must be between -100 and 100"
			-- 			end,
			-- 		},
			-- 	},
			-- 	user = {
			-- 		order = 9,
			-- 		mapping = "parameters",
			-- 		type = "string",
			-- 		optional = true,
			-- 		default = nil,
			-- 		desc = "A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. Learn more.",
			-- 		validate = function(u)
			-- 			return u:len() < 100, "Cannot be longer than 100 characters"
			-- 		end,
			-- 	},
			},
		}
	-- return {
	-- 	name = "anthropic",
	-- 	env = {
	-- 		api_key = 'cmd:gpg --decrypt --batch --passphrase " " /Users/nlyssogor/Documents/.claude_key.txt.gpg 2>/dev/null',
	-- 	},
	-- 	schema = {
	-- 		model = {
	-- 			order = 1,
	-- 			mapping = "parameters",
	-- 			type = "enum",
	-- 			desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
	-- 			default = "claude-3-opus-20240229",
	-- 			choices = {
	-- 				"claude-3-opus-20240229",
	-- 				"claude-3-sonnet-20240229",
	-- 				"claude-2.1",
	-- 			},
	-- 		},
	-- 		max_tokens = {
	-- 			order = 2,
	-- 			mapping = "parameters",
	-- 			type = "number",
	-- 			optional = true,
	-- 			default = 4096,
	-- 			desc = "The maximum number of tokens to generate in the chat completion. The total length of input tokens and generated tokens is limited by the model's context length.",
	-- 			validate = function(n)
	-- 				return n > 0, "Must be greater than 0"
	-- 			end,
	-- 		},
	-- 		temperature = {
	-- 			order = 3,
	-- 			mapping = "parameters",
	-- 			type = "number",
	-- 			optional = true,
	-- 			default = 0,
	-- 			desc = "What sampling temperature to use, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
	-- 			validate = function(n)
	-- 				return n >= 0 and n <= 1, "Must be between 0 and 1"
	-- 			end,
	-- 		},
	-- 	},
	-- }
	elseif neovim_env == "work" then
		return {
			name = "ollama",
			env = {},
			schema = {
				model = {
					order = 1,
					mapping = "parameters",
					type = "enum",
					desc = "ID of the model to use.",
					default = "llama3:8b-instruct-fp16",
					choices = {
            "llama3:8b-instruct-fp16",
						"qwen-32b",
						"deepseek-coder:33b",
					},
				},
				temperature = {
					order = 2,
					mapping = "parameters.options",
					type = "number",
					optional = true,
					default = 0.0,
					desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
					validate = function(n)
						return n >= 0 and n <= 2, "Must be between 0 and 2"
					end,
				},
			},
		}
	else
		return {
			name = "openai",
			env = {},
			schema = {},
		}
	end
end

-- function M.format_as_md()
-- 	vim.cmd("setlocal wrap linebreak breakindent nonumber norelativenumber")
-- 	vim.opt_local.conceallevel = 2
-- 	vim.opt_local.formatlistpat = "^\\s*[0-9\\-\\+\\*]\\+[\\.\\)]*\\s\\+"
-- 	vim.cmd([[set breakindentopt=list:-1,shift:0,sbr]])
-- 	vim.opt_local.breakat = " \t;:,!?"
-- end

return M
