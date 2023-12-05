-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- use({ "jaredgorski/spacecamp" })

	-- use("blazkowolf/gruber-darker.nvim")

	use({ "nyoom-engineering/oxocarbon.nvim" })

	-- 	use({
	-- 		"rose-pine/neovim",
	-- 		as = "rose-pine",
	-- 		config = function()
	-- 			require("rose-pine").setup({
	-- 				dark_variant = "moon",
	-- 				bold_vert_split = true,
	-- 				disable_float_background = true,
	-- 				disable_background = true,
	-- 				dim_nc_background = false,
	--
	-- 				disable_italics = true,
	-- 			})
	-- 			vim.o.background = "dark"
	-- 			vim.cmd("colorscheme rose-pine")
	-- 		end,
	-- 	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({ "mbbill/undotree" })

	use({ "neovim/nvim-lspconfig" })
	use({
		"williamboman/mason.nvim",
		run = function()
			pcall(vim.cmd, "MasonUpdate")
		end,
	})
	use({ "williamboman/mason-lspconfig.nvim" })

	-- Autocompletion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-nvim-lsp" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use({ "kaarmu/typst.vim", ft = { "typst" } })

	use({ "mhartington/formatter.nvim" })

	use({ "jbyuki/nabla.nvim" })

	use({ "jakewvincent/mkdnflow.nvim" })

	use({ "preservim/vim-markdown" })

	use({ "HiPhish/rainbow-delimiters.nvim" })

	use({ "m4xshen/autoclose.nvim" })

	use({ "lervag/vimtex" })

	use({ "folke/zen-mode.nvim" })

	use({
		"L3MON4D3/LuaSnip",
		run = "make install_jsregexp",
	})

	use({ "xiyaowong/transparent.nvim" })

	use({ "ziglang/zig.vim" })
end)
