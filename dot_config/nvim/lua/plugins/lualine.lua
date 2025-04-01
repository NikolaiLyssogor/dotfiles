return {
  "nvim-lualine/lualine.nvim",
  commit = "f4f791f67e70d378a754d02da068231d2352e5bc",
  pin = true,
  event = "VeryLazy",
  opts = {
    options = {
      theme = "jellybeans",
    },
    sections = {
      lualine_x = { 'filetype' }
    }
  },
}
