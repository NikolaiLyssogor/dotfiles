return {
  {
    "wtfox/jellybeans.nvim",
    commit = "0231cbb415b01e4650568ff690ab36fa978b4973",
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
