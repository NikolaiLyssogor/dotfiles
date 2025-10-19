return {
  {
    "lewis6991/gitsigns.nvim",
    commit = "20ad4419564d6e22b189f6738116b38871082332",
    pin = true,
    lazy = false,
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', '<leader>gn', function()
            if vim.wo.diff then
              vim.cmd.normal({ '<leader>gn', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '<leader>gp', function()
            if vim.wo.diff then
              vim.cmd.normal({ '<leader>gp', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>gs', gitsigns.stage_hunk)
          map('n', '<leader>gr', gitsigns.reset_hunk)

          map('v', '<leader>gs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('v', '<leader>gr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>gd', gitsigns.preview_hunk_inline)

          map('n', '<leader>gb', function()
            gitsigns.blame_line({ full = true })
          end)

          map('n', '<leader>gq', function() gitsigns.setqflist('all') end)
        end
      }
    end,
  },
}
