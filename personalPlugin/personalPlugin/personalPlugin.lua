vim.api.nvim_create_user_command("openNotesFile", require("personalPlugin").openNotesFile(), {})
vim.api.nvim_create_user_command("closeNotesWindow", require("personalPlugin").closeNotesWindow(), {})
