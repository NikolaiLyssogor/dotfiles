return {
  {
    "wtfox/jellybeans.nvim",
    commit = "07a40854d5c1a158de513c996a23de244eda198e",
    pin = true,
    lazy = false,
    name = "jellybeans",
    priority = 1000,
    config = function(opts)
      require("jellybeans").setup(opts)
      vim.cmd.colorscheme("jellybeans")
    end,
  },
}
