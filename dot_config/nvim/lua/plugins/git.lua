return {
  {
    "lewis6991/gitsigns.nvim",
    tag = "v2.0.0",
    pin = false,
    lazy = false,
    keys = {
      { "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "[d]iff preview" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",          desc = "[r]eset hunk" },
      { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>",           desc = "[n]ext hunk" },
      { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>",           desc = "[p]revious hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>",          desc = "[a]dd hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>",     desc = "[u]ndo stage hunk" },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches({ confirm = "gitsigns_change_base" })
          require("core.highlights").enable_review_mode()
        end,
        desc = "change [b]ase"
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_base(true)
          require("core.highlights").disable_review_mode()
        end,
        desc = "[R]eset base"
      },
      {
        "<leader>gq",
        function()
          local gitsigns = require("gitsigns")

          local before = vim.fn.getqflist({ id = 0 })
          local before_id = before.id

          gitsigns.setqflist("all", { open = false })

          local timeout_ms = 1500
          local interval_ms = 20
          local start = vim.loop.hrtime()

          ---@return boolean
          local function timed_out()
            local elapsed_ms = (vim.loop.hrtime() - start) / 1e6
            return elapsed_ms >= timeout_ms
          end

          local function poll()
            local qf = vim.fn.getqflist({ id = 0, items = 0 })

            if qf.id ~= before_id then
              if #qf.items == 0 then
                vim.notify("No hunks.", vim.log.levels.WARN)
                return
              end
              Snacks.picker.qflist()
              return
            end

            if timed_out() then
              vim.notify("Operation to set qickfix list with git hunks timed out.", vim.log.levels.ERROR)
              return
            end

            vim.defer_fn(poll, interval_ms)
          end

          poll()
        end,
        desc = "[q]uickfix list hunks"
      },
    },
  },
}
