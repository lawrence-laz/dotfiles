local home = vim.fn.expand("~/notes")

require('telekasten').setup({
    home              = home,
    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,
    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,
    -- dir names for special notes (absolute path or subdir name)
    dailies           = home .. '/' .. 'journal',
    weeklies          = home .. '/' .. 'weekly',
    templates         = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "attachments",

    -- markdown file extension
    extension = ".md",

    -- Generate note filenames. One of:
    -- "title" (default) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename = "title",
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly = home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "ivy",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "ivy",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,

    -- vaults = {
    --     vault2 = {
    --         -- alternate configuration for vault2 here. Missing values are defaulted to
    --         -- default values from telekasten.
    --         -- e.g.
    --         -- home = "/home/user/vaults/personal",
    --     },
    -- },

    -- how to preview media files
    -- "telescope-media-files" if you have telescope-media-files.nvim installed
    -- "catimg-previewer" if you have catimg installed
    media_previewer = "catimg-previewer",

    -- A customizable fallback handler for urls.
    follow_url_fallback = nil,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "telekasten" },
    callback = function()

        vim.opt.wrap = true -- Wrap long lines
        vim.opt.linebreak = true -- Don't break inside word

        vim.keymap.set("n", "<leader>zf", require('telekasten').find_notes)
        vim.keymap.set("n", "<leader>zd", require('telekasten').find_daily_notes)
        vim.keymap.set("n", "<leader>zg", require('telekasten').search_notes)
        vim.keymap.set("n", "<leader>zz", require('telekasten').follow_link)
        vim.keymap.set("n", "<F12>", require('telekasten').follow_link)
        vim.keymap.set("n", "<leader>zT", require('telekasten').goto_today)
        vim.keymap.set("n", "<leader>zW", require('telekasten').goto_thisweek)
        vim.keymap.set("n", "<leader>zw", require('telekasten').find_weekly_notes)
        vim.keymap.set("n", "<leader>zn", require('telekasten').new_note)
        vim.keymap.set("n", "<leader>zN", require('telekasten').new_templated_note)
        vim.keymap.set("n", "<leader>zy", require('telekasten').yank_notelink)
        vim.keymap.set("n", "<leader>zc", require('telekasten').show_calendar)
        vim.keymap.set("n", "<leader>zC", "<cmd>CalendarT<cr>")
        vim.keymap.set("n", "<leader>zi", require('telekasten').paste_img_and_link)
        vim.keymap.set("n", "<leader>zt", require('telekasten').toggle_todo)
        vim.keymap.set("n", "<leader>zb", require('telekasten').show_backlinks)
        vim.keymap.set("n", "<leader>zp", require('telekasten').preview_img)
        vim.keymap.set("n", "<leader>zm", require('telekasten').browse_media)
        vim.keymap.set("n", "<leader>za", require('telekasten').show_tags)
        vim.keymap.set("n", "<leader>#", require('telekasten').show_tags)
        vim.keymap.set("n", "<leader>zr", require('telekasten').rename_note)

        -- TODO: <C-Del> insert more delete next word
        -- on hesitation, bring up the panel
        vim.keymap.set("n", "<leader>z", require('telekasten').panel)

        vim.keymap.set("i", "[[[", function() require('telekasten').insert_link({ i = true }) end)
    end,
})
