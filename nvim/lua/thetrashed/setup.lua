-- Editor settings
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.fillchars = { eob = " " }

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

vim.opt.filetype = "on"
vim.opt.syntax = "enable"
vim.api.nvim_command("filetype plugin on")

vim.opt.mouse = ""
vim.wo.conceallevel = 2
vim.opt.concealcursor = ""

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.autochdir = true

vim.filetype.add({ extension = {
	typ = "typst",
	asy = "asy",
	h = "c",
	hpp = "cpp",
	c = "c",
	cpp = "cpp",
} })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "set awa",
})

-- Call TexlabBuild each time a .tex file is saved
--
-- Define the function to be called on file save
function OnTexSave()
	if vim.fn.getbufvar(vim.fn.bufnr("%"), "&mod") == 1 then
		vim.api.nvim_command("TexlabBuild")
	end
end

local texFiles = vim.api.nvim_create_augroup("texFiles", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "texFiles",
	pattern = { "*.tex" },
	callback = function()
		if vim.fn.getbufvar(0, "&mod") then
			vim.api.nvim_notify("Exectuing: TexlabBuild", 0, {})
			vim.api.nvim_command("TexlabBuild")
		end
	end,
})

-- local allFiles = vim.api.nvim_create_augroup('allFiles', { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     group = 'allFiles',
--     pattern = { '*' },
--     callback = function()
--         vim.lsp.buf.format()
--     end,
-- })
vim.cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWriteLock
    augroup END
]])

-- vim.g.vimwiki_list = { {
--     path = '~/Wiki/src',
--     syntax = 'markdown',
--   index = 'index',
-- ext = '.md',
-- } }

vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_math = 1

vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_matchparen_enabled = 0

vim.g.tex_fast = "Mm"
vim.g.tex_conceal = ""
vim.g.tex_conceal_frac = 0
vim.g.tex_flavor = "latex"

vim.g.transparent_enabled = true
