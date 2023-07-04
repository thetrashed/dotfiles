vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- File manager

-- Allows copying to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Splitting
vim.keymap.set("n", "<leader>pp", vim.cmd.vnew) -- Vertical
vim.keymap.set("n", "<leader>ph", vim.cmd.new)  -- Horizontal
vim.keymap.set("n", "<leader>k", "<C-W>k")
vim.keymap.set("n", "<leader>j", "<C-W>j")
vim.keymap.set("n", "<leader>h", "<C-W>h")
vim.keymap.set("n", "<leader>l", "<C-W>l")

vim.keymap.set("n", "<leader>=", ":vertical resize +5<CR>")
vim.keymap.set("n", "<leader>-", ":vertical resize -5<CR>")
vim.keymap.set("n", "<leader>]", ":horizontal resize +5<CR>")
vim.keymap.set("n", "<leader>[", ":horizontal resize -5<CR>")

-- Toggle highlighting
vim.keymap.set("n", "<C-h>", vim.cmd.nohl)

vim.keymap.set("n", "<leader>re", ":TexlabBuild<CR>")
