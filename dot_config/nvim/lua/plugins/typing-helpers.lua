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
        Rule('"""', '"""', { 'codecompanion' }),
        Rule('""".*$', '"""', { "codecompanion" }):only_cr():use_regex(true),
      })
    end
  },
  {
    "towolf/vim-helm",
    commit = "2c8525fd98e57472769d137317bca83e477858ce",
    pin = true
  }
}
