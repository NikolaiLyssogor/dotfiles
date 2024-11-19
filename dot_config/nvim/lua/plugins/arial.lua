return {
  "stevearc/aerial.nvim",
  commit = "24ebacab5821107c50f628e8e7774f105c08fe9b",
  pin = true,
  event = "VeryLazy",
  dependenciesc = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>cs", "<cmd>AerialToggle!<CR>", desc = "[s]ymbols" }
  },
  config = function()
    require("aerial").setup({
      disable_max_lines = 30000,
    })
  end,
}
