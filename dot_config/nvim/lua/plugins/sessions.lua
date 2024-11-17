return {
  {
    "rmagatti/auto-session",
    tag = "v2.5.0",
    pin = true,
    enabled = true,
    config = function()
      require("auto-session").setup({
        -- log_level = "debug",
        auto_session_enabled = true,
        auto_session_create_enabled = false,
        -- auto_restore_enabled = false,
        -- auto_save_enabled = true,
        auto_session_suppress_dirs = {
          "~/",
          "~/Projects",
          "~/Downloads",
          "/",
          "~/Documents",
          "~/Applications",
          "~/Desktop",
        },

        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      })

      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

      local session_lens = require("auto-session.session-lens")
      require("which-key").register({
        s = {
          name = "[s]essions",
          s = { session_lens.search_session, "[s]earch sessions" },
          d = { ":Autosession delete<cr>", "[d]elete session" },
          c = { ":SessionSave<cr>", "[c]reate session" },
        },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
}
