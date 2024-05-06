return {
  "stevearc/aerial.nvim",
  commit = "24ebacab5821107c50f628e8e7774f105c08fe9b",
  pin = true,
  event = "VeryLazy",
  dependenciesc = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      disable_max_lines = 30000,
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })

    -- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>"),
    require("which-key").register({
      c = {
        name = "[c]ode",
        s = { "<cmd>AerialToggle!<CR>", "[s]ymbols" },
      },
    }, { mode = "n", prefix = "<leader>" })
  end,
}
