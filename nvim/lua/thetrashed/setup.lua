-- Editor settings
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.encoding = "utf-8"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 30

vim.opt.spell = true
vim.opt.spelllang = "en_gb,en_us"
vim.opt.spellfile = os.getenv("HOME") .. "/.vim/spell/en.utf-8.add"

vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.opt.filetype = 'on'
vim.opt.syntax = 'enable'
vim.api.nvim_command('filetype plugin on')

vim.opt.mouse = ''
vim.opt.conceallevel = 2

-- Call TexlabBuild each time a .tex file is saved
--
-- Define the function to be called on file save
function onTexSave()
    if vim.fn.getbufvar(vim.fn.bufnr('%'), '&mod') == 1 then
        vim.api.nvim_command('TexlabBuild')
    end
end

-- local texFiles = vim.api.nvim_create_augroup('texFiles', { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     group = 'texFiles',
--     pattern = { '*.tex' },
--     callback = function()
--         if vim.fn.getbufvar(0, '&mod') then
--             vim.api.nvim_notify('Exectuing: TexlabBuild', 0, {})
--             vim.api.nvim_command('TexlabBuild')
--         end
--     end,
-- })

-- local allFiles = vim.api.nvim_create_augroup('allFiles', { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     group = 'allFiles',
--     pattern = { '*' },
--     callback = function()
--         vim.lsp.buf.format()
--     end,
-- })

vim.filetype.add({ extension = { typ = 'typst', asy = 'asy' } })
