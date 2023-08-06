require('mkdnflow').setup({
    modules = {
        bib = false,
        buffers = true,
        conceal = false,
        cursor = true,
        folds = false,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        yaml = false
    },
    filetypes = { md = true, rmd = false, markdown = true },
    create_dirs = true,
    perspective = {
        priority = 'current',
        fallback = 'current',
        root_tell = 'index.md',
        nvim_wd_heel = false,
        update = false
    },
    wrap = true,
    bib = {
        default_path = nil,
        find_in_root = true
    },
    silent = true,
    links = {
        style = 'markdown',
        name_is_source = false,
        conceal = true,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            text = os.date('%Y-%m-%d_') .. text
            return (text)
        end
    },
    new_file_template = {
        use_template = false,
        placeholders = {
            before = {
                title = "link_title",
                date = "os_date"
            },
            after = {}
        },
        template = "# {{ title }}"
    },
    to_do = {
        symbols = { ' ', '-', 'X' },
        update_parents = true,
        not_started = ' ',
        in_progress = '-',
        complete = 'X'
    },
    tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = true,
        auto_extend_cols = true,
    },
    yaml = {
        bib = { override = false }
    },
    mappings = {
        MkdnEnter = { { 'n', 'v' }, '<CR>' },
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = { 'n', '<Tab>' },
        MkdnPrevLink = { 'n', '<S-Tab>' },
        MkdnNextHeading = { 'n', ']]' },
        MkdnPrevHeading = { 'n', '[[' },
        MkdnGoBack = { 'n', '<BS>' },
        MkdnGoForward = { 'n', '<Del>' },
        MkdnCreateLink = false,                                      -- see MkdnEnter
        MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>p' }, -- see MkdnEnter
        MkdnFollowLink = false,                                      -- see MkdnEnter
        MkdnDestroyLink = { 'n', '<M-CR>' },
        MkdnTagSpan = { 'v', '<M-CR>' },
        MkdnMoveSource = { 'n', '<F2>' },
        MkdnYankAnchorLink = { 'n', 'yaa' },
        MkdnYankFileAnchorLink = { 'n', 'yfa' },
        MkdnIncreaseHeading = { 'n', '+' },
        MkdnDecreaseHeading = { 'n', '-' },
        MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = { 'n', 'o' },
        MkdnNewListItemAboveInsert = { 'n', 'O' },
        MkdnExtendList = false,
        MkdnUpdateNumbering = { 'n', '<leader>nn' },
        MkdnTableNextCell = { 'i', '<Tab>' },
        MkdnTablePrevCell = { 'i', '<S-Tab>' },
        MkdnTableNextRow = { 'i', '<leader><CR>' },
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = { 'n', '<leader>ir' },
        MkdnTableNewRowAbove = { 'n', '<leader>iR' },
        MkdnTableNewColAfter = { 'n', '<leader>ic' },
        MkdnTableNewColBefore = { 'n', '<leader>iC' },
        MkdnTableFormat = { 'n', '<leader>t' },
        MkdnFoldSection = { 'n', '<leader>f' },
        MkdnUnfoldSection = { 'n', '<leader>F' }
    }
})
