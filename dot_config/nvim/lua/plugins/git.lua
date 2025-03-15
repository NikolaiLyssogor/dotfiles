return {
  {
    "lewis6991/gitsigns.nvim",
    tag = "v1.0.1",
    pin = true,
    lazy = false,
    keys = {
      { "<leader>gd", "<cmd>gitsigns preview_hunk<cr>",    desc = "[d]iff preview" },
      { "<leader>gr", "<cmd>gitsigns reset_hunk<cr>",      desc = "[r]eset hunk" },
      { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>",       desc = "[n]ext hunk" },
      { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>",       desc = "[p]revious hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>",      desc = "[a]dd hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "[u]ndo stage hunk" },
    },
    config = function()
      require("gitsigns").setup()
    end,
  },
}
