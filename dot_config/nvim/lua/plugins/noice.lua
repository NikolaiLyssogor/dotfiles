return {
  "folke/noice.nvim",
  tag = "v2.0.1",
  pin = true,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({})
  end,
}
