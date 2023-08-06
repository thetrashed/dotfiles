require('luasnip').config.set_config({
    enable_autosnippets = true,
    store_selection_keys = '<Tab>',
})

require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/LuaSnip/' })
