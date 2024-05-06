return {
  "nvim-lualine/lualine.nvim",
  commit = "0a5a66803c7407767b799067986b4dc3036e1983",
  pin = true,
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
    })
  end,
}
