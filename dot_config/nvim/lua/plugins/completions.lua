return {
  {
    "saghen/blink.cmp",
    tag = "v0.11.0",
    pin = true,
    opts = {

      keymap = {
        preset = "default",
        ["<Tab>"] = { "accept", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },

      snippets = { preset = "default" },

      sources = {
        default = { "lsp", "path", "snippets" },
      },

      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { window = { border = "single" } },
        menu = { border = "single" },
      },

      signature = { enabled = true, window = { border = "single" } },
    },

    opts_extend = { "sources.default" },
  },
}
