return {
  {
    "wtfox/jellybeans.nvim",
    commit = "3204baaab2888874e6eca302de57b57bcba085b9",
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
