return {
  {
    "catppuccin/nvim",
    tag = "v1.6.0",
    pin = true,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        latte = {
          green = "#1a8c00",
          lavender = "#4561ff",
          peach = "#eb5d0c",
          sky = "#049cd9",
          yellow = "#d6830e",
          -- base = "#d6dae1",
        },
        mocha = {
          -- base = "#000000",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      local function set_toggle_light_dark_theme()
        local home = os.getenv("HOME")
        local filepath = home .. "/.local/share/nvim/my-data/theme.txt"
        local readfile = io.open(filepath, "r")

        if readfile then
          local curr_theme = readfile:read("*l")
          curr_theme = string.gsub(curr_theme, "^%s*(.-)%s*$", "%1")
          if curr_theme == "dark" then
            vim.o.background = "light"
            vim.api.nvim_command("Catppuccin latte")
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#e2e2e8" })
            vim.api.nvim_set_hl(0, "CodeCompanionTokens", { bg = "#ccd0da" })
            local writefile = io.open(filepath, "w+")
            if writefile then
              writefile:write("light")
              writefile:close()
            else
              print("ERROR: Failed to open file when writing light theme")
            end
          elseif curr_theme == "light" then
            vim.o.background = "dark"
            vim.api.nvim_command("Catppuccin mocha")
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#262538" })
            vim.api.nvim_set_hl(0, "CodeCompanionTokens", { bg = "#313244" })
            local writefile = io.open(filepath, "w+")
            if writefile then
              writefile:write("dark")
              writefile:close()
            else
              print("ERROR: Failed to open file when writing dark theme")
            end
          else
            print("ERROR: Theme file found unexpected setting " .. curr_theme)
          end
          readfile:close()
        else
          print("ERROR: Could not open " .. filepath .. " when setting theme.")
        end
      end

      local function get_light_dark_theme()
        local home = os.getenv("HOME")
        local filepath = home .. "/.config/nvim/.data/theme.txt"
        local readfile = io.open(filepath, "r")

        if readfile then
          local curr_theme = readfile:read("*l")
          curr_theme = string.gsub(curr_theme, "^%s*(.-)%s*$", "%1")
          if curr_theme == "dark" then
            vim.o.background = "dark"
            vim.api.nvim_command("Catppuccin mocha")
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#262538" })
            vim.api.nvim_set_hl(0, "CodeCompanionTokens", { bg = "#313244" })
          elseif curr_theme == "light" then
            vim.o.background = "light"
            vim.api.nvim_command("Catppuccin latte")
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#e2e2e8" })
            vim.api.nvim_set_hl(0, "CodeCompanionTokens", { bg = "#ccd0da" })
          else
            print("ERROR: Theme file has unknown value, defaulting to dark theme")
            vim.o.background = "dark"
            vim.api.nvim_command("Catppuccin mocha")
            local writefile = io.open(filepath, "w+")
            if writefile then
              writefile:write("dark")
              writefile:close()
            else
              print("ERROR: Failed to write to theme file when defaulting theme to dark.")
            end
          end
        end
      end

      get_light_dark_theme()

      require("which-key").register({
        v = {
          name = "[v]im general settings",
          t = { set_toggle_light_dark_theme, "[t]oggle light/dark theme" },
        },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
}
