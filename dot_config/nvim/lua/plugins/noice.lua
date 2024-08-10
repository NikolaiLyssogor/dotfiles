return {
  "folke/noice.nvim",
  tag = "v4.5.0",
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
