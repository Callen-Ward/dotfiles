local gears                    = require('gears')
local awful                    = require('awful')
local wibox                    = require('wibox')
local beautiful                = require('beautiful')
local settings                 = require('settings')

-- system tray widget
beautiful.systray_icon_spacing = 2
local mysystray                = wibox.widget.systray()
mysystray.set_base_size(22)
local mysystraywrapper = {
    widget = wibox.container.margin,
    right = 10,
    mysystray
}

-- volume widget
local myvolumewidget   = require('awesome-wm-widgets.pactl-widget.volume')
    { step = 2, mixer_cmd = settings.terminalcmd .. settings.mixercmd }

-- clock widget
local mytextclock      = wibox.widget.textclock('[%a %d/%m %H:%M]')

-- click handler for the taglist
local taglist_buttons  = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ settings.modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ settings.modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end)
)

-- click handler for the tasklist
local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                'request::activate',
                'tasklist',
                { raise = true }
            )
        end
    end))

local function make_wibar(s)
    -- box widget with icon indicating current layout
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- tasklist widget, only show clients with tags that are currently visible
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- create wibar with previously defined widgets
    s.mywibox = awful.wibar { position = 'top', screen = s }
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist
        },
        s.mytasklist,
        {
            widget = wibox.container.margin,
            left = 10,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                mysystraywrapper,
                myvolumewidget,
                mytextclock,
                s.mylayoutbox
            }
        }
    }
end

return make_wibar
