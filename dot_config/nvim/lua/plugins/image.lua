return {
  { -- show images in nvim!
    -- see pinned issue about installin on MacOS
    -- https://github.com/3rd/image.nvim/issues/18
    "3rd/image.nvim",
    commit = "9be5ede323756d7ee2bbef2bc157767b3972cce6",
    pin = true,
    enabled = true,
    -- lazy = true,
    config = function()
      -- Requirements
      -- https://github.com/3rd/image.nvim?tab=readme-ov-file#requirements
      -- check for dependencies with `:checkhealth kickstart`
      -- otherwise set `enabled = false` in the plugin spec
      -- -- Example for configuring Neovim to load user-installed installed Lua rocks:
      --$ luarocks --local --lua-version=5.1 install magick
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki", "quarto" },
          },
        },
        max_width = 100,                      -- tweak to preference
        max_height = 12,                      -- ^
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  },
}
