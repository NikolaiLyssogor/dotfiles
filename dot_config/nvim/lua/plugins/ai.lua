return {
  {
    "olimorris/codecompanion.nvim",
    tag = "v14.2.2",
    pin = true,
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>lc",
        function()
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
- If asked to write code in Python, Typescript, or Lua, include type annotations that would pass a type-checker's strictest settings. Assume python >= 3.12 (e.g. use `list` instead of `List`)
- Emphasize clean code in our response. Avoid excessively nested if-else blocks and loop unless necessary.
- You may get asked questions not relevant to software engineering. It is fine to answer them.
]]
        end,
      },
      display = {
        chat = {
          window = {
            position = "right",
            width = 0.25,
          },
        },
        diff = { enabled = false },
      },
      strategies = {
        chat = {
          adapter = os.getenv("HOME") == "/Users/nlyssogor" and "openai" or "azure_openai",
          slash_commands = { ["file"] = { opts = { provider = "snacks" } } },
        },
        inline = { adapter = os.getenv("HOME") == "/Users/nlyssogor" and "openai" or "azure_openai" },
      },
      adapters = {
        opts = { show_defaults = false },

        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = require("core.utils").gpg_secret_cmd("openai-key.txt.gpg"),
            },
            schema = { model = { default = "gpt-4.1", choices = { "gpt-4.1", "o4-mini" } } }
          })
        end,

        azure_openai = function()
          local utils = require("core.utils")
          local endpoint = utils.read_file_first_line(os.getenv("HOME") .. "/Documents/secrets/azure-openai-endpoint.txt")
          local api_key = utils.gpg_secret_cmd("openai-key.txt.gpg")

          return require("codecompanion.adapters").extend("azure_openai", {
            env = {
              endpoint = endpoint,
              api_key = api_key,
              api_version = "2025-03-01-preview",
            },
            schema = { model = { default = "gpt-4.1", choices = { "gpt-4.1", "o4-mini" } } },
            headers = {
              ["Content-Type"] = "application/json",
              Authorization = "Bearer ${api_key}",
            }
          })
        end,

        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = require("core.utils").gpg_secret_cmd("anthropic-key.txt.gpg"),
            },
            schema = {
              model = {
                default = "claude-3-7-sonnet-latest",
                choices = { "claude-3-7-sonnet-latest" }
              }
            }
          })
        end,

        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = os.getenv("HOME") == "/Users/nlyssogor" and "qwen2.5-coder:14b" or "qwen2.5-coder:32b",
              },
            },
          })
        end,
      },
    },
  },
}
