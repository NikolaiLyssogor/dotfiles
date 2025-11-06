return {
  "kylechui/nvim-surround",
  tag = "v2.3.2",
  pin = true,
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup()
  end,
}
