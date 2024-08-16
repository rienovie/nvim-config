---@class CustomModule

local M = {}

M.notesWinOpen = false

M.open_notes_window = function()
	if M.notesWinOpen then
		return
	end
	local NotesBuffer = vim.api.nvim_create_buf(false, true)
	local popupOpts = {
		title = "Rienovie Neovim Notes",
		line = math.floor(((vim.o.lines - 25) / 2) - 1),
		col = math.floor((vim.o.columns - 90) / 2),
		minwidth = 90,
		minheight = 25,
		borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
		border = true,
	}

	local _, pu = require("plenary.popup").create(NotesBuffer, popupOpts)
	vim.api.nvim_win_set_var(pu.win_id, "winhl", "Notes")
	vim.opt_local.number = true
	vim.opt_local.cursorline = true
	vim.opt_local.cursorlineopt = "both"

	vim.api.nvim_buf_set_keymap(NotesBuffer, "n", "<Esc>", "<cmd>:q!<CR>", { noremap = true, silent = true })

	local file = vim.fn.stdpath("data") .. "/Notes.txt"
	vim.api.nvim_buf_call(NotesBuffer, function()
		vim.cmd("edit " .. file)
	end)
	M.notesWinOpen = true
end

return M
