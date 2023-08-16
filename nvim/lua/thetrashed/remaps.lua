vim.g.mapleader = " "
local kmap = vim.keymap.set

kmap("n", "<leader>pv", vim.cmd.Ex) -- File manager

-- Allows copying to clipboard
kmap("n", "<leader>y", '"+y')
kmap("v", "<leader>y", '"+y')
kmap("n", "<leader>Y", '"+Y')

-- Splitting
kmap("n", "<leader>pp", vim.cmd.vnew) -- Vertical
kmap("n", "<leader>ph", vim.cmd.new) -- Horizontal
kmap("n", "<leader>k", "<C-W>k")
kmap("n", "<leader>j", "<C-W>j")
kmap("n", "<leader>h", "<C-W>h")
kmap("n", "<leader>l", "<C-W>l")

kmap("n", "<leader>=", ":vertical resize +5<CR>")
kmap("n", "<leader>-", ":vertical resize -5<CR>")
kmap("n", "<leader>]", ":horizontal resize +5<CR>")
kmap("n", "<leader>[", ":horizontal resize -5<CR>")

-- Toggle highlighting
kmap("n", "<C-h>", vim.cmd.nohl)

kmap("n", "<leader>re", ":TexlabBuild<CR>")

kmap("n", "<leader>z", ":ZenMode<CR>", { silent = true })

-- Wiki
kmap("n", "<leader>ww", ":e ~/Wiki/src/index.md<CR>", { silent = true })
kmap("n", "<leader>wt", ":e ~/Wiki/src/tasks.md<CR>", { silent = true })

-- Format the file
kmap("n", "<leader>f", ":FormatWriteLock<CR>", { silent = true })
