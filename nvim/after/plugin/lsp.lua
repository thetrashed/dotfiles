local lspconfig = require("lspconfig")
local luasnip = require("luasnip")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup({})
require("mason-lspconfig").setup()

local on_attach = function(_, bufnr)
	local opts = { buffer = buf, remap = false }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition(), opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover(), opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol(), opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float(), opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next(), opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev(), opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action(), opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references(), opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename(), opts)
	vim.keymap.set("n", "<leader>gh", vim.lsp.buf.signature_help(), opts)
end

local servers = {
	"bashls",
	"clangd",
	"cssls",
	"eslint",
	"html",
	"lua_ls",
	"pyright",
	"taplo",
	"texlab",
	"typst_lsp",
	"zls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspconfig.typst_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		exportPdf = "never",
	},
})

local cmp = require("cmp")
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(cmp_select)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.select_prev_item(cmp_select) then
				cmp.select_prev_item(cmp_select)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

vim.diagnostic.config({
	virtual_text = true,
})
