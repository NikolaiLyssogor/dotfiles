-- defaults that might get overridden by autocmds
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.wo.relativenumber = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move through wrapped lines instead of around them
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- scrolling options
vim.api.nvim_set_keymap("", "<ScrollWheelUp>", "<C-Y>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<ScrollWheelDown>", "<C-E>", { noremap = true, silent = true })

-- shift window horizontall by 5 by default
vim.api.nvim_set_keymap("n", "zl", "5zl", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "zh", "5zh", { noremap = true, silent = true })

-- move to start/end of text from home row
vim.api.nvim_set_keymap("n", "L", "g_", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "H", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "L", "g_", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "H", "^", { noremap = true, silent = true })

-- required by modicator but also nice to have
vim.o.cursorline = true
vim.o.number = true
vim.o.termguicolors = true

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

-- set nerdfont
vim.o.guifont = "JetBrainsMono Nerd Font:style=Regular,Regular:h12.5"

-- remove tilde at end of buffer
vim.opt.fillchars = { eob = " " }

-- resize windows
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

-- indent/unindent with tab/shift-tab
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- always yank to system clipboard
vim.opt.clipboard = "unnamed"

-- html/css/js/ts settings
local function set_webdev_settings()
	vim.opt_local.tabstop = 2
	vim.opt_local.softtabstop = 2
	vim.opt_local.shiftwidth = 2
	vim.opt_local.conceallevel = 0
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "lua", "html", "css", "javascript", "typescript", "typescriptreact" },
	callback = set_webdev_settings,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "json" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		set_webdev_settings()
	end,
})

-- markdown and markdown-like autocmds
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*codecompanion*", "*.md" },
	callback = function()
		vim.wo.smoothscroll = true
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.conceallevel = 2
		vim.opt_local.formatlistpat = "^\\s*[0-9\\-\\+\\*]\\+[\\.\\)]*\\s\\+"
		vim.opt_local.breakindentopt = "list:-1,shift:0,sbr"
		vim.opt_local.breakat = " \t;:,!?"
	end,
})

-- unmap this to avoidconflict with nvim-autopairs
vim.cmd([[let g:completion_confirm_key = ""]])

-- don't show mode on command line
vim.o.showmode = false

-- always use block cursor
vim.opt.guicursor = "n-v-c:block"

-- Remap Ctrl-e to move cursor 10 lines down
vim.api.nvim_set_keymap("n", "<C-e>", "10<C-e>", { noremap = true, silent = true })

-- Remap Ctrl-y to move cursor 10 lines up
vim.api.nvim_set_keymap("n", "<C-y>", "10<C-y>", { noremap = true, silent = true })

-- Remap Ctrl-d to move cursor 10 lines down
vim.api.nvim_set_keymap("n", "<C-d>", "10<C-d>", { noremap = true, silent = true })

-- Remap Ctrl-u to move cursor 10 lines up
vim.api.nvim_set_keymap("n", "<C-u>", "10<C-u>", { noremap = true, silent = true })

-- Status bar spans whole screen
vim.o.laststatus = 3
