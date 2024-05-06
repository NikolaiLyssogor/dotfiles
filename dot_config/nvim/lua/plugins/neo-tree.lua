return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("which-key").register({
            f = {
                name = "[f]iles",
                d = { ":Neotree filesystem reveal float<CR>", "show [d]irectory" },
                b = { ":Neotree buffers reveal float<CR>", "show open [b]uffers" },
            },
        }, { mode = "n", prefix = "<leader>" })
    end,
}
