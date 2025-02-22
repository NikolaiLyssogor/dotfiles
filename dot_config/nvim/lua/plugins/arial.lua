return {
  "stevearc/aerial.nvim",
  tag = "v2.5.0",
  pin = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>cs", "<cmd>AerialToggle!<CR>", desc = "[s]ymbols" },
  },
  opts = {
    disable_max_lines = 30000,
  },
}
