return {
  {
    "windwp/nvim-autopairs",
    commit = "3d02855468f94bf435db41b661b58ec4f48a06b7",
    pin = true,
    event = "InsertEnter",
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({ map_cr = true })

      -- Add triple backtick rule to CodeCompanion
      local Rule = require('nvim-autopairs.rule')
      npairs.add_rules({
        Rule('```', '```', { 'codecompanion' }),
        Rule("```.*$", "```", { "codecompanion" }):only_cr():use_regex(true),
      })
    end
  },
  {
    "kylechui/nvim-surround",
    tag = "v2.3.2",
    pin = true,
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "towolf/vim-helm",
    commit = "2c8525fd98e57472769d137317bca83e477858ce",
    pin = true
  }
}
