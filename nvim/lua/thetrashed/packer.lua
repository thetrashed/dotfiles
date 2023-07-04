-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                dark_variant = 'moon',
                bold_vert_split = true,
                disable_float_background = true,
                disable_background = true,
                dim_nc_background = false,

                disable_italics = true,
            })
            vim.o.background = 'dark'
            vim.cmd('colorscheme rose-pine')
        end
    }

    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })

    use('nvim-treesitter/playground')

    use { 'mbbill/undotree' }

    use { 'ThePrimeagen/harpoon' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-buffer' },   -- Required
            { 'hrsh7th/cmp-path' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required

            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { 'kaarmu/typst.vim', ft = { 'typst' } }

    use { 'lukas-reineke/lsp-format.nvim' }

    use { 'jbyuki/nabla.nvim' }

    use {
        'nvim-neorg/neorg',
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }
end)
