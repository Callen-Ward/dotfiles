local gears = require('gears')
local awful = require('awful')
local settings = require('settings')

-- global key bindings
local globalkeys = gears.table.join(
-- use arrow keys to switch tags
    awful.key({ settings.modkey }, 'Left', awful.tag.viewprev),
    awful.key({ settings.modkey }, 'Right', awful.tag.viewnext),
    awful.key({ settings.modkey }, 'Escape', awful.tag.history.restore),

    -- focus client
    awful.key({ settings.modkey }, 'j', function() awful.client.focus.byidx(1) end),
    awful.key({ settings.modkey }, 'k', function() awful.client.focus.byidx(-1) end),
    awful.key({ settings.modkey }, 'u', awful.client.urgent.jumpto),
    awful.key({ settings.modkey }, 'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),

    -- focus screens
    awful.key({ settings.modkey, 'Control' }, 'j', function() awful.screen.focus_relative(1) end),
    awful.key({ settings.modkey, 'Control' }, 'k', function() awful.screen.focus_relative(-1) end),

    -- change client order
    awful.key({ settings.modkey, 'Shift' }, 'j', function() awful.client.swap.byidx(1) end),
    awful.key({ settings.modkey, 'Shift' }, 'k', function() awful.client.swap.byidx(-1) end),

    -- resize master
    awful.key({ settings.modkey }, 'l', function() awful.tag.incmwfact(0.05) end),
    awful.key({ settings.modkey }, 'h', function() awful.tag.incmwfact(-0.05) end),

    -- change number of master clients
    awful.key({ settings.modkey, 'Shift' }, 'h', function() awful.tag.incnmaster(1, nil, true) end),
    awful.key({ settings.modkey, 'Shift' }, 'l', function() awful.tag.incnmaster(-1, nil, true) end),

    -- change number of columns
    awful.key({ settings.modkey, 'Control' }, 'h', function() awful.tag.incncol(1, nil, true) end),
    awful.key({ settings.modkey, 'Control' }, 'l', function() awful.tag.incncol(-1, nil, true) end),

    -- switch layouts
    awful.key({ settings.modkey }, 'space', function() awful.layout.inc(1) end),
    awful.key({ settings.modkey, 'Shift' }, 'space', function() awful.layout.inc(-1) end),

    -- restore minimized client
    awful.key({ settings.modkey, 'Control' }, 'n', function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal('request::activate', 'key.unminimize', { raise = true })
        end
    end),

    -- restart/quit awesome
    awful.key({ settings.modkey, 'Control' }, 'r', awesome.restart),
    awful.key({ settings.modkey, 'Shift' }, 'q', awesome.quit),

    -- launch programs
    awful.key({ settings.modkey }, 'Return', function() awful.spawn(settings.terminalcmd) end),
    awful.key({ settings.modkey }, 'b', function() awful.spawn(settings.browsercmd) end),
    awful.key({ settings.modkey }, 'e', function() awful.spawn(settings.editorcmd) end),
    awful.key({ 'Mod1' }, ' ', function() awful.spawn(settings.launchercmd) end),
    awful.key({ settings.modkey, 'Shift' }, 's', function() awful.spawn('flameshot gui') end))

-- client key bindings
local clientkeys = gears.table.join(
-- kill
    awful.key({ settings.modkey, 'Shift' }, 'c', function(c) c:kill() end),

    -- minimise
    awful.key({ settings.modkey }, 'n', function(c) c.minimized = true end),

    -- switch index with master
    awful.key({ settings.modkey, 'Control' }, 'Return', function(c) c:swap(awful.client.getmaster()) end),

    -- move to next screen
    awful.key({ settings.modkey }, 'o', function(c) c:move_to_screen() end),

    -- toggle floating
    awful.key({ settings.modkey, 'Control' }, 'space', awful.client.floating.toggle),

    -- toggle always on top
    awful.key({ settings.modkey }, 't', function(c) c.ontop = not c.ontop end),

    -- toggle fullscreen/maximised
    awful.key({ settings.modkey }, 'f', function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),
    awful.key({ settings.modkey }, 'm', function(c)
        c.maximized = not c.maximized
        c:raise()
    end),
    awful.key({ settings.modkey, 'Control' }, 'm', function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end),
    awful.key({ settings.modkey, 'Shift' }, 'm', function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end))

-- bind number keys to tags using keycodes for layout compatibility
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,

        -- view tag only.
        awful.key({ settings.modkey }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end),

        -- toggle visibility
        awful.key({ settings.modkey, 'Control' }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end),

        -- move client to tag.
        awful.key({ settings.modkey, 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end),

        -- toggle tag on focused client.
        awful.key({ settings.modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end))
end

-- use mouse buttons to move and resize windows
local clientbuttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
        end),
    awful.button({ settings.modkey }, 1,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
            awful.mouse.client.move(c)
        end),
    awful.button({ settings.modkey }, 3,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
            awful.mouse.client.resize(c)
        end))

return {
    globalkeys = globalkeys,
    clientkeys = clientkeys,
    clientbuttons = clientbuttons
}
