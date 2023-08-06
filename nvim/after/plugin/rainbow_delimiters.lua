local rainbow = require('rainbow-delimiters')

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = function()
            if vim.fn.line('$') > 10000 then
                return nil
            end

            return rainbow.strategy['global']
        end,
    },
    query = {
        [''] = 'rainbow-delimiters',
        html = 'rainbow-blocks',
        latex = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}
