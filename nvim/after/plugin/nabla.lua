local nabla = require("nabla")

vim.keymap.set("n", "<leader>q", ":lua require('nabla').popup()<CR>", { silent = true })
