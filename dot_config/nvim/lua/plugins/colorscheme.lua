return {
  {
    "catppuccin/nvim",
    commit = "4bb938bbba41d306db18bf0eb0633a5f28fd7ba0",
    pin = true,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        blink_cmp = true,
      },
    },
    config = function(opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
