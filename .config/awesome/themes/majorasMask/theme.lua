-- ==============================
-- = Libraries & Base           =
-- ==============================
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = {}

-- ==============================
-- = Variables                     =
-- ==============================
local taglist_square_size = dpi(4)
wibarColor = "#00000000"
widgetBorderColor = "#80808080"
widgetBackgroundColor = "#00000080" 
alertColor = "#ff0000"
textColor = "#aaaaaa"

-- ==============================
-- = Theme Definition           =
-- ==============================
theme.font = "Departure Mono"
theme.wallpaper = "~/.config/awesome/themes/majorasMask/wallpaper.png"
theme.tasklist_disable_task_name = true
theme.useless_gap = dpi(5)
theme.border_width  = dpi(2)
theme.bg_normal = wibarColor
theme.bg_focus = widgetBorderColor
theme.bg_urgent = alertColor
theme.fg_normal = textColor
theme.border_normal = wibarColor
theme.border_focus  = widgetBorderColor

theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.bg_minimize = "#ff0000"
theme.bg_systray = "#00000000"
theme.fg_focus = "#ff0000"
theme.fg_urgent = "#ff0000"
theme.fg_minimize = "#ff0000"

theme.icon_theme = "Sweet-Rainbow"

theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

return theme