---@class CustomModule

local M = {}

M.notesWinOpen = false

M.close_notes_window = function()
	local lines = vim.api.nvim_buf_get_lines(M.NotesBuffer, 0, -1, false)
	local finalOut = ""
	for _, value in ipairs(lines) do
		finalOut = finalOut .. value .. "\n"
	end
	local file = vim.fn.stdpath("data") .. "/Notes.txt"
	io.output(file)
	io.write(finalOut)
	io.close()

	M.notesWinOpen = false
	vim.api.nvim_win_close(0, true)
	M.NotesBuffer = nil
end

M.open_notes_window = function()
	if M.notesWinOpen then
		return
	end
	M.notesWinOpen = true

	M.NotesBuffer = vim.api.nvim_create_buf(false, true)
	local popupOpts = {
		title = "Rienovie Neovim Notes",
		line = math.floor(((vim.o.lines - 25) / 2) - 1),
		col = math.floor((vim.o.columns - 90) / 2),
		minwidth = 90,
		minheight = 25,
		borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
		border = true,
	}

	local _, pu = require("plenary.popup").create(M.NotesBuffer, popupOpts)
	vim.api.nvim_win_set_var(pu.win_id, "winhl", "Notes")

	local file = vim.fn.stdpath("data") .. "/Notes.txt"
	local fileContents = {}
	for line in io.lines(file) do
		table.insert(fileContents, line)
	end

	vim.api.nvim_buf_set_lines(M.NotesBuffer, 0, -1, false, fileContents)
	vim.opt_local.number = true
	vim.opt_local.cursorline = true
	vim.opt_local.cursorlineopt = "both"

	vim.api.nvim_buf_set_keymap(
		M.NotesBuffer,
		"n",
		"<Esc>",
		":lua require('personalPlugin').closeNotesWindow()<CR>",
		{ noremap = true, silent = true }
	)
end

return M
