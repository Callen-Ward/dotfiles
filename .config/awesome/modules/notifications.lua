local naughty                      = require('naughty')
local xresources                   = require('beautiful.xresources')
local beautiful                    = require('beautiful')

local dpi                          = xresources.apply_dpi

naughty.config.defaults.max_width  = dpi(500)
naughty.config.defaults.max_height = dpi(150)
naughty.config.padding             = beautiful.useless_gap * 2
