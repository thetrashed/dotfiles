local neorg = require("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.neorgcmd"] = {},
        ["core.concealer"] = {
            config = {
                folds = false,
                dim_code_blocks = {
                    enable = true,
                    concealer = true,
                },
            },
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Notes",
                },
                default_workspace = "notes",
                index = "index.norg",
            },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            }
        },
        ["core.esupports.hop"] = {},
        ["core.export"] = {
            config = {
                export_dir = "~/Notes/Exports",
            },
        },
        ["core.export.markdown"] = {},
        ["core.summary"] = {},
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.remap_event("norg", "n", "<Tab>", "core.integrations.treesitter.next.link",
                        { silent = true })
                    keybinds.remap_event("norg", "n", "<S-Tab>", "core.integrations.treesitter.previous.link",
                        { silent = true })
                    keybinds.remap("norg", "n", "<C-q>", "<cmd>Neorg return<CR>", { silent = true })
                end
            },
        }
    },
})

vim.keymap.set("n", "<leader>ww", function()
    vim.api.nvim_parse_cmd('Neorg workspace', {})
    vim.cmd('Neorg index')
end, { silent = true })
