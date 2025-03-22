return {
	{
		"olimorris/codecompanion.nvim",
		tag = "v14.2.2",
		pin = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>lc",
				function()
					vim.cmd("wincmd L")
					vim.cmd("CodeCompanionChat Toggle")
				end,
				desc = "[c]hat window toggle",
			},
			{
				"<leader>la",
				"<cmd>CodeCompanionChat Add<cr><esc>",
				mode = "v",
				desc = "[a]dd visual selection to chat",
			},
		},
		opts = {
        opts = {
          system_prompt = function(opts)
            return [[
You are an AI pair-programming assistant embedded in an engineer's editor. Your have the skills and experience of a principal engineer. You will be asked questions by someone with a few years of professional experience as a software engineer.

You must:
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must be in %s.
- If asked to write code in Python, Typescript, or Lua, include type annotations that would pass a type-checker's strictest settings. Assume python >= 3.12 (e.g. use `list` instead of `List`)
- Emphasize clean code in our response. Avoid excessively nested if-else blocks and loop unless necessary.
- You may get asked questions not relevant to software engineering. It is fine to answer them.
]]
          end,
        },
			display = {
				chat = {
          auto_scroll = false,
					window = {
						position = "right",
						width = 0.25,
					},
				},
			},
			strategies = {
				chat = {
					adapter = os.getenv("HOME") == "/Users/nlyssogor" and "anthropic" or "openai",
					slash_commands = { ["file"] = { opts = { provider = "snacks" } } },
				},
				inline = { adapter = "openai" },
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = os.getenv("HOME") == "/Users/nlyssogor" and "qwen2.5-coder:14b"
									or "qwen2.5-coder:32b",
							},
						},
					})
				end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = string.format(
								'cmd:gpg --decrypt --batch --passphrase " " %s/Documents/secrets/anthropic-key.txt.gpg 2>/dev/null',
								os.getenv("HOME")
							),
            },
          })
        end,
				openai = function()
					local home = os.getenv("HOME")

					local function readUrl()
						local filename = home .. "/Documents/secrets/azure-openai-url.txt"
						local file = io.open(filename, "r")
						if not file then
							error("Could not open file: " .. filename)
						end
						local line = file:read("*line")
						file:close()
						return line
					end

					local url = home == "/Users/nlyssogor" and "https://api.openai.com/v1/chat/completions" or readUrl()

					return require("codecompanion.adapters").extend("openai", {
						url = url,
						env = {
							api_key = string.format(
								'cmd:gpg --decrypt --batch --passphrase " " %s/Documents/secrets/openai-key.txt.gpg 2>/dev/null',
								home
							),
						},
						headers = {
							["Content-Type"] = "application/json",
							["api-key"] = "${api_key}",
						},
					})
				end,
			},
		},
	},
}
