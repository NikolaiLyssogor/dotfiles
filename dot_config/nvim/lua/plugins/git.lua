return {
  {
    "lewis6991/gitsigns.nvim",
    commit = "c097cb255096f333e14d341082a84f572b394fa2",
    pin = true,
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()
      require("which-key").register({
        g = {
          name = "[g]it",
          d = { gitsigns.preview_hunk, "[d]iff preview" },
          r = { gitsigns.reset_hunk, "[r]eset hunk" },
          n = { "<cmd>Gitsigns next_hunk<CR>", "[n]ext hunk"},
          p = { "<cmd>Gitsigns prev_hunk<CR>", "[p]revious hunk"},
        },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
}
