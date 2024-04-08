local theme_assets                   = require('beautiful.theme_assets')
local xresources                     = require('beautiful.xresources')
local gfs                            = require('gears.filesystem')
local naughty                        = require('naughty')

local dpi                            = xresources.apply_dpi
local themes_path                    = gfs.get_themes_dir()

local theme                          = {}

theme.font                           = 'firacodenerdfont medium 9'

local tokyonight_night_colours       = {
    bg = "#1a1b26",
    bg_dark = "#16161e",
    bg_highlight = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    dark5 = "#737aa2",
    blue0 = "#3d59a1",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8",
    blue7 = "#394b70",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
    git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
    gitSigns = {
        add = "#266d6a",
        change = "#536c9e",
        delete = "#b2555b",
    },

}

theme.bg_normal                      = tokyonight_night_colours.bg_dark
theme.bg_focus                       = tokyonight_night_colours.bg_highlight
theme.bg_urgent                      = tokyonight_night_colours.red

theme.fg_normal                      = tokyonight_night_colours.fg
theme.fg_urgent                      = tokyonight_night_colours.red1
theme.fg_minimize                    = tokyonight_night_colours.fg_dark

theme.useless_gap                    = dpi(4)
theme.border_width                   = dpi(2)

theme.border_normal                  = tokyonight_night_colours.comment
theme.border_focus                   = theme.border_normal
theme.border_marked                  = theme.border_normal

naughty.config.defaults.border_width = theme.border_width
naughty.config.defaults.border_color = theme.border_normal

theme.wallpaper                      = '~/Pictures/bgs/tokyonight-night.png'

-- generate taglist squares:
local taglist_square_size            = dpi(4)
theme.taglist_squares_sel            = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel          = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

theme.layout_fairh                   = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv                   = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating                = themes_path .. 'default/layouts/floatingw.png'
theme.layout_magnifier               = themes_path .. 'default/layouts/magnifierw.png'
theme.layout_max                     = themes_path .. 'default/layouts/maxw.png'
theme.layout_fullscreen              = themes_path .. 'default/layouts/fullscreenw.png'
theme.layout_tilebottom              = themes_path .. 'default/layouts/tilebottomw.png'
theme.layout_tileleft                = themes_path .. 'default/layouts/tileleftw.png'
theme.layout_tile                    = themes_path .. 'default/layouts/tilew.png'
theme.layout_tiletop                 = themes_path .. 'default/layouts/tiletopw.png'
theme.layout_spiral                  = themes_path .. 'default/layouts/spiralw.png'
theme.layout_dwindle                 = themes_path .. 'default/layouts/dwindlew.png'
theme.layout_cornernw                = themes_path .. 'default/layouts/cornernww.png'
theme.layout_cornerne                = themes_path .. 'default/layouts/cornernew.png'
theme.layout_cornersw                = themes_path .. 'default/layouts/cornersww.png'
theme.layout_cornerse                = themes_path .. 'default/layouts/cornersew.png'

return theme
