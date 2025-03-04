-- ==============================
-- = Libraries & Base           =
-- ==============================
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
pcall(require, "luarocks.loader")
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- ==============================
-- = Error Handling             =
-- ==============================
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- ==============================
-- = Variable Definitions       =
-- ==============================
availableThemes = {
    "majorasMask",
    "zect",
}

theme = availableThemes[1]

beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/theme.lua")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
}

function custom_shape(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)    
end

-- ==============================
-- = Launch on Startup          =
-- ==============================
awful.spawn.with_shell('picom --config ~/.config/picom/picom.conf -b')
-- awful.spawn.with_shell("mpv --fs --quiet ~/.config/awesome/themes/" .. theme .. "/intro.mp4")
awful.spawn.with_shell('whatsdesk')
awful.spawn.with_shell('floorp')
awful.spawn.with_shell('discord')
awful.spawn.with_shell('steam')

-- ==============================
-- = Taglist Buttons            =
-- ==============================
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
        
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- ==============================
-- = Tasklist Buttons           =
-- ==============================
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function(c) c:kill() end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)

-- ==============================
-- = Wallpaper Function         =
-- ==============================
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- ==============================
-- = Wallpaper Reseter          =
-- ==============================
screen.connect_signal("property::geometry", set_wallpaper)

-- ==============================
-- = Screens                    =
-- ==============================
awful.screen.connect_for_each_screen(function(s)

    -- ==============================
    -- = Set Wallpaper              =
    -- ==============================
    set_wallpaper(s)

    -- ==============================
    -- = Layout Box                 =
    -- ==============================
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end))
    )

    -- ==============================
    -- = Taglist                    =
    -- ==============================
    awful.tag.add("one", {
        icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag1.png",
        layout = awful.layout.layouts[1],
        screen = s,
        selected = true,
        icon_only = true,
    })
    
    awful.tag.add("two", {
        icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag2.png",
        layout = awful.layout.layouts[1],
        screen = s,
        icon_only = true,
    })
    
    awful.tag.add("three", {
        icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag3.png",
        layout = awful.layout.layouts[1],
        screen = s,
        icon_only = true,
    })
    
    awful.tag.add("four", {
        icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag4.png",
        layout = awful.layout.layouts[1],
        screen = s,
        icon_only = true,
    })
        
    awful.tag.add("five", {
        icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag5.png",
        layout = awful.layout.layouts[1],
        screen = s,
        icon_only = true,
    })
    
    -- awful.tag.add("twentysix", {
    --     icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag26.png",
    --     layout = awful.layout.layouts[1],
    --     screen = s,
    --     icon_only = true,
    -- })
    
    -- awful.tag.add("twentyseven", {
    --     icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag27.png",
    --     layout = awful.layout.layouts[1],
    --     screen = s,
    --     icon_only = true,
    -- })
    
    -- awful.tag.add("twentyeight", {
    --     icon = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/tag28.png",
    --     layout = awful.layout.layouts[1],
    --     screen = s,
    --     icon_only = true,
    -- })
                
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        shape = custom_shape,
    }

    -- ==============================
    -- = Tasklist                   =
    -- ==============================
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }

    -- ==============================
    -- = Widgets                    =
    -- ==============================
    mylauncher = awful.widget.launcher({ 
        image = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/icons/launcher.png", 
        command = "rofi -show drun -show-icons" 
    })

    local separator = wibox.widget {
        widget = wibox.widget.separator,
        orientation = "vertical",
        forced_width = 10,
        color = widgetBorderColor,
        visible = true
    }

    local separatorInvisible = wibox.widget {
        widget = wibox.widget.separator,
        orientation = "vertical",
        forced_width = 5,
        color = wibarColor,
        visible = true
    }

    local batteryarc_widget = require("widgets.batteryarc-widget.batteryarc")
    local brightness_widget = require("widgets.brightness-widget.brightness")
    local calendar_widget = require("widgets.calendar-widget.calendar")
    local volume_widget = require('widgets.volume-widget.volume')
    local logout_popup = require("widgets.logout-popup-widget.logout-popup")
    local todo_widget = require("widgets.todo-widget.todo")

    local cw = calendar_widget({
        theme = 'nord',
        placement = 'top_right',
        start_sunday = true,
        radius = 8,
        previous_month_button = 1,
        next_month_button = 3,
    })
    textclock_widget = wibox.widget.textclock()
    textclock_widget:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then cw.toggle() end
    end)

    s.mymem = awful.widget.watch('bash -c "free -h | awk \'/^Mem/ {print $3}\'"' ,30)

    
    -- ==============================
    -- = Wibox                      =
    -- ==============================
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s, 
        height = 30, 
        opacity = 1, 
        bg = wibarColor,
    })

    local function create_bordered_widget(widget, bg_color)
        return wibox.widget {
            {
                {
                    widget,
                    bg = bg_color,
                    shape = custom_shape,
                    widget = wibox.container.background
                },
                left = 1,
                right = 1,
                top = 1,
                bottom = 1,
                widget = wibox.container.margin
            },
            bg = widgetBorderColor,
            shape = custom_shape,
            widget = wibox.container.background
        }
    end
    
    s.mywibox:setup {
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            { 
                create_bordered_widget(
                    {
                        layout = wibox.layout.fixed.horizontal,
                        separatorInvisible,
                        mylauncher,
                        separatorInvisible,
                    },
                    widgetBackgroundColor
                ),
                separatorInvisible,
                create_bordered_widget(
                    {
                        layout = wibox.layout.fixed.horizontal,
                        s.mytasklist,
                    },
                    widgetBackgroundColor
                ),
                layout = wibox.layout.fixed.horizontal,
            },
            nil,
            { 
                create_bordered_widget(
                    {
                        layout = wibox.layout.fixed.horizontal,
                        separator,
                        s.mymem,
                        textclock_widget,
                        -- batteryarc_widget({
                        --    show_current_level = true,
                        --    arc_thickness = 1,
                        -- }),
                        separator,
                        -- brightness_widget(),
                        todo_widget(),
                        volume_widget{
                            widget_type = 'arc'
                        },
                        logout_popup.widget{
                            accent_color = "#4c566a",
                            label_color = "#88c0d0",
                            text_color = "#88c0d0"
                        },
                        separator,
                        s.mylayoutbox,
                    },
                    widgetBackgroundColor
                ),
                layout = wibox.layout.fixed.horizontal,
            },
        },
        { 
            layout = wibox.container.place,
            valign = "center",
            halign = "center",
            create_bordered_widget(
                {
                    layout = wibox.layout.fixed.horizontal,
                    s.mytaglist,
                },
                widgetBackgroundColor
            ),
        },
    }
end)

-- ==============================
-- = Key Bindings               =
-- ==============================
globalkeys = gears.table.join(
    awful.key({modkey}, "h", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    awful.key({}, "Print", function () awful.spawn("flameshot gui") end ),
    awful.key({modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({modkey}, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),
    awful.key({modkey}, "t", function () awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey }, "l", function() awful.util.spawn("rofi -show-icon -show drun") end, {description = "application launcher", group = "launcher"}),
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%+", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume up", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%-", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume down", group = "hotkeys"}
    )
                    
)

clientkeys = gears.table.join(
    awful.key({modkey}, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key({modkey}, "q", function (c) c:kill() end, {description = "close", group = "client"}),
    awful.key({modkey}, "s", function (c) c:move_to_screen() end, {description = "swap screen", group = "client"}),
    awful.key({modkey}, "n",
        function (c)
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}
    ),
    awful.key({modkey}, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}
    )
)

clientbuttons = gears.table.join(
    awful.button({}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({modkey}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({modkey}, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

-- ==============================
-- = Rules                      =
-- ==============================
awful.rules.rules = {
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },
    {
        rule_any = {class = {"firefox"}},
        properties = {
            tag = screen[1].tags[1]
        }
    },
    {
        rule_any = {class = {"whatsdesk", "discord", "steam"}},
        properties = {
            tag = screen[2].tags[5]
        }
    },
}

-- ==============================
-- = Signals                    =
-- ==============================
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)