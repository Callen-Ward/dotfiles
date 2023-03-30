local theme_assets                   = require('beautiful.theme_assets')
local xresources                     = require('beautiful.xresources')
local gfs                            = require('gears.filesystem')
local naughty                        = require('naughty')

local dpi                            = xresources.apply_dpi
local themes_path                    = gfs.get_themes_dir()

local theme                          = {}

theme.font                           = 'firacodenerdfont medium 9'

theme.bg_normal                      = '#12131d'
theme.bg_focus                       = '#222436'
theme.bg_urgent                      = '#ff757f'

theme.fg_normal                      = '#c8d3f5'
theme.fg_urgent                      = '#c53b53'
theme.fg_minimize                    = '#828bb8'

theme.useless_gap                    = dpi(4)
theme.border_width                   = dpi(2)

theme.border_normal                  = '#7a88cf'
theme.border_focus                   = theme.border_normal
theme.border_marked                  = theme.border_normal

naughty.config.defaults.border_width = theme.border_width
naughty.config.defaults.border_color = theme.border_normal

theme.wallpaper                      = '~/Pictures/bgs/tokyonight.png'

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
