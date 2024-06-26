return {
	-- {
	--     "quarto-dev/quarto-nvim",
	--     ft = { "quarto" },
	--     dev = false,
	--     dependencies = {
	--         {
	--             "jmbuhr/otter.nvim",
	--             dev = false,
	--             dependencies = {
	--                 { "neovim/nvim-lspconfig" },
	--             },
	--             config = function()
	--                 require("otter").setup({
	--                     lsp = {
	--                         hover = {
	--                             -- border = require("misc.style").border,
	--                             border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--                         },
	--                     },
	--                     buffers = {
	--                         set_filetype = true,
	--                     },
	--                     handle_leading_whitespace = true,
	--                 })
	--             end,
	--         },
	--     },
	--     config = function()
	--         require("quarto").setup({
	--             -- chunks = "all", -- 'curly' (default) or 'all'
	--             lspFeatures = {
	--                 enabled = true,
	--                 languages = { "python", "bash", "lua", "html" },
	--                 diagnostics = {
	--                     enabled = true,
	--                     triggers = { "InsertLeave", "BufWrite", "InsertEnter" }, -- BufWrite, InsertEnter
	--                 },
	--                 completion = { enabled = true },
	--             },
	--             codeRunner = {
	--                 enabled = true,
	--                 default_method = "molten", -- "slime" or "molten"
	--                 never_run = { "yaml" },
	--             },
	--             keymap = {
	--                 -- set whole section or individual keys to `false` to disable
	--                 -- NOTE: Make sure these match mappings in lsp-config.lua
	--                 hover = "<leader>ch",
	--                 definition = "<leader>cd",
	--                 type_definition = "<leader>ct",
	--                 rename = "<leader>cr",
	--                 format = false,
	--                 references = false,
	--                 document_symbols = false,
	--             },
	--         })
	--
	--         vim.g["quarto_is_r_mode"] = nil
	--         vim.g["reticulate_running"] = false
	--
	--         --- Send code to terminal with vim-slime
	--         --- If an R terminal has been opend, this is in r_mode
	--         --- and will handle python code via reticulate when sent
	--         --- from a python chunk.
	--         --- TODO: incorpoarate this into quarto-nvim plugin
	--         --- such that QuartoRun functions get the same capabilities
	--         local function send_cell()
	--             if vim.b["quarto_is_r_mode"] == nil then
	--                 vim.fn["slime#send_cell"]()
	--                 return
	--             end
	--             if vim.b["quarto_is_r_mode"] == true then
	--                 vim.g.slime_python_ipython = 0
	--                 local is_python = require("otter.tools.functions").is_otter_language_context("python")
	--                 if is_python and not vim.b["reticulate_running"] then
	--                     vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
	--                     vim.b["reticulate_running"] = true
	--                 end
	--                 if not is_python and vim.b["reticulate_running"] then
	--                     vim.fn["slime#send"]("exit" .. "\r")
	--                     vim.b["reticulate_running"] = false
	--                 end
	--                 vim.fn["slime#send_cell"]()
	--             end
	--         end
	--
	--         local is_code_chunk = function()
	--             local current, _ = require("otter.keeper").get_current_language_context()
	--             if current then
	--                 return true
	--             else
	--                 return false
	--             end
	--         end
	--
	--         --- Insert code chunk of given language
	--         --- Splits current chunk if already within a chunk
	--         --- @param lang string
	--         local insert_code_chunk = function(lang)
	--             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	--             local keys
	--             if is_code_chunk() then
	--                 keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
	--             else
	--                 keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
	--             end
	--             keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	--             vim.api.nvim_feedkeys(keys, "n", false)
	--         end
	--
	--         local insert_r_chunk = function()
	--             insert_code_chunk("r")
	--         end
	--
	--         local insert_py_chunk = function()
	--             insert_code_chunk("python")
	--         end
	--
	--         local insert_bash_chunk = function()
	--             insert_code_chunk("bash")
	--         end
	--
	--         local function move_to_next_python_block()
	--             vim.cmd([[silent! execute "/```{python}\\n" ]])
	--             vim.cmd([[silent! execute  "noh" ]])
	--             vim.cmd([[silent! execute "normal! j" ]])
	--             vim.cmd([[silent! execute "normal! 0" ]])
	--         end
	--
	--         local function move_to_previous_python_block()
	--             local is_python = require("otter.tools.functions").is_otter_language_context("python")
	--
	--             vim.cmd([[silent! execute "normal! 0" ]])
	--             vim.cmd([[silent! execute "/```{python}\\n" ]])
	--             if is_python then
	--                 vim.cmd([[silent! execute  "normal! N" ]])
	--             end
	--             vim.cmd([[silent! execute  "normal! N" ]])
	--             vim.cmd([[silent! execute  "noh" ]])
	--             vim.cmd([[silent! execute  "normal! j" ]])
	--         end
	--
	--         require("which-key").register({
	--             -- ["<cr>"] = { send_cell, "run code cell" },
	--             t = {
	--                 name = "[t]erminal",
	--                 p = { ":vertical split term://python<cr>", "new [p]ython terminal" },
	--                 i = { ":vertical split term://ipython<cr>", "new [i]python terminal" },
	--             },
	--             q = {
	--                 name = "[q]uarto",
	--                 -- r = { insert_r_chunk, "[r] code chunk" },
	--                 b = { insert_py_chunk, "insert python [b]lock" },
	--                 -- b = { insert_bash_chunk, "[b]ash code chunk" },
	--                 P = { ":lua require'quarto'.quartoPreview()<cr>", "[P]review" },
	--                 Q = { ":lua require'quarto'.quartoClosePreview()<cr>", "[Q]uit preview" },
	--                 c = { ":QuartoSend<cr>", "run [c]ell" },
	--                 a = { ":QuartoSendAbove<cr>", "run [a]bove" },
	--                 A = { ":QuartoSendAll<cr>", "run [A]ll" },
	--                 n = { move_to_next_python_block, "[n]ext code block" },
	--                 p = { move_to_previous_python_block, "[p]revious code block" },
	--             },
	--         }, { mode = "n", prefix = "<leader>" })
	--     end,
	-- },
	-- {
	--     "benlubas/molten-nvim",
	--     build = ":UpdateRemotePlugins",
	--     init = function()
	--         vim.g.molten_image_provider = "image.nvim"
	--         vim.g.molten_output_win_max_height = 40
	--         vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
	--         vim.g.molten_use_border_highlights = true
	--         vim.g.molten_virt_text_output = true
	--         vim.g.molten_auto_open_output = false
	--         vim.g.molten_tick_rate = 142
	--
	--         -- see https://github.com/benlubas/molten-nvim?tab=readme-ov-file#commands
	--         require("which-key").register({
	--             m = {
	--                 name = "[m]olten",
	--                 I = { ":MoltenInit<CR>", "[I]nit" },
	--                 s = { ":noautocmd MoltenEnterOutput<CR>", "[s]how output" },
	--                 h = { ":MoltenHideOutput<CR>", "[h]ide output" },
	--                 r = { ":MoltenRestart<CR>", "[r]estart kernel" },
	--                 R = { ":MoltenRestart!<CR>", "[r]estart and delete output" },
	--                 i = { ":MoltenInterrupt<CR>", "[i]interrupt execution" },
	--                 S = { ":MoltenSave<CR>", "[S]ave cells and outputs" },
	--                 L = { ":MoltenLoad<CR>", "[L]oad cells and outputs" },
	--             },
	--         }, { mode = "n", prefix = "<localleader>" })
	--
	--         vim.api.nvim_create_autocmd("User", {
	--             pattern = "MoltenDeinitPre",
	--             callback = function()
	--                 vim.cmd(":MoltenSave")
	--             end,
	--         })
	--     end,
	-- },
}
