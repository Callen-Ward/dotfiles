local gears     = require('gears')
local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')

require('awful.autofocus')

-- switch to fallback config if there is an error during startup
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = 'error during startup',
        text = awesome.startup_errors
    }
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = 'there was an error',
            text = tostring(err)
        }
        in_error = false
    end)
end

-- initialise theme
beautiful.init(gears.filesystem.get_configuration_dir() .. 'themes/tokyonight-night.lua')

require('modules.notifications')

local settings = require('settings')
local make_wibar = require('modules.wibar')
local keybinds = require('modules.keybinds')

-- set layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

-- set global key bindings
root.keys(keybinds.globalkeys)

-- rules
awful.rules.rules = {
    -- all clients
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keybinds.clientkeys,
            buttons = keybinds.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any =
        {
            role =
            { 'pop-up' }
        },
        properties = {
            floating = true
        }
    }
}

-- executed when a new client appears
client.connect_signal('manage', function(c)
    -- put new clients at end of client list
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- change border colour when client is focused
client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)

-- function to set the wallpaper
local function set_wallpaper(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s)
end

-- re-set wallpaper when a screen's geometry changes
screen.connect_signal('property::geometry', set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    -- add a tag table, set the default layout for all tags
    awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])

    -- add a wibar to each screen
    make_wibar(s)
end)

-- autostart
for _, program in pairs(settings.autostart) do
    awful.spawn.with_shell(program)
end
