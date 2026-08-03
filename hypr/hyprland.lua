hl.config({
  debug = {
    disable_logs = false,
  },

  ecosystem = {
    no_update_news = true,
  },
})

local terminal = "ghostty"
local fileManager = "thunar"
local menu = "rofi -show combi"
local mainMod = "SUPER"

local function raw_dispatch(cmd)
  return function()
    hl.exec_cmd("hyprctl dispatch " .. cmd)
  end
end

local function load_plugin_file(path)
  local f = io.open(path, "r")
  if not f then
    return
  end

  for line in f:lines() do
    local plugin = line:match("^%s*plugin%s*=%s*(.-)%s*$")
    if plugin ~= nil and plugin ~= "" then
      hl.plugin.load(plugin)
    end
  end

  f:close()
end

hl.monitor({ output = "eDP-1", mode = "1920x1080",      position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-1", mode = "1920x1080",     position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-2",   mode = "1920x1080@165", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080",   position = "1920x0", scale = 1 })

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

load_plugin_file("/etc/hypr/hy3-plugin.conf")

local hy3 = hl.plugin.hy3

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl keyword plugin:hy3:node_collapse_policy 0")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tab_first_window true")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:height 16")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:radius 4")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:border_width 1")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:active rgba(303030ff)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:active_border rgba(595959aa)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:inactive rgba(30303044)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:inactive_border rgba(595959aa)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:urgent rgba(ff2233aa)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:tabs:colors:urgent_border rgba(ff2233ee)")
  hl.exec_cmd("hyprctl keyword plugin:hy3:autotile:enable true")
  hl.exec_cmd("hyprctl keyword plugin:hy3:autotile:trigger_width 800")
  hl.exec_cmd("hyprctl keyword plugin:hy3:autotile:trigger_height 500")
end)

require("hyprland.autostart")
require("hyprland.look_and_feel")

hl.window_rule({
  name = "zen-pip",
  match = {
    title = "^Picture%-in%-Picture$",
    class = "^(zen|zen%-beta)$",
  },
  float = true,
  pin = true,
})

hl.window_rule({
  name = "telegram-window",
  match = {
    title = "^TelegramDesktop$",
  },
  float = true,
  size = ">1 <600",
})

hl.window_rule({
  name = "telegram-media-viewer",
  match = {
    title = "^Media viewer$",
  },
  float = true,
  move = "cursor -50% -50%",
})

hl.window_rule({
  name = "hyprland-share-picker",
  match = {
    class = "^hyprland%-share%-picker$",
  },
  float = true,
  size = "500 300",
  move = "cursor -50% -50%",
})

hl.config({
  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },

  input = {
    kb_layout = "br",
    kb_variant = "abnt2",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    repeat_delay = 250,
    repeat_rate = 50,
    follow_mouse = 1,
    sensitivity = 0,
    accel_profile = "flat",

    touchpad = {
      natural_scroll = false,
      scroll_factor = 0.5,
    },
  },

  gestures = {
    workspace_swipe_touch = true,
  },
})

hl.device({
  name = "logitech-gaming-mouse-g600",
  sensitivity = 0.4,
})

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd("clipmenu -p clipboard"))
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + Q",             hy3 ~= nil and hy3.kill_active() or raw_dispatch("hy3:killactive"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M",             hl.dsp.exit())
hl.bind(mainMod .. " + W",             hy3 ~= nil and hy3.make_group("tab", { toggle = true }) or raw_dispatch("hy3:makegroup tab toggle"))
hl.bind(mainMod .. " + E",             hy3 ~= nil and hy3.make_group("v", { toggle = true }) or raw_dispatch("hy3:makegroup v toggle"))

hl.bind(mainMod .. " + F",         raw_dispatch("fullscreen 1"))
hl.bind(mainMod .. " + SHIFT + F", raw_dispatch("fullscreen 0"))

hl.bind(mainMod .. " + TAB", raw_dispatch("swapactiveworkspaces HDMI-A-2 DP-2"))
hl.bind("code:193",           raw_dispatch("swapactiveworkspaces HDMI-A-2 DP-2"))

hl.bind(mainMod .. " + H", hy3 ~= nil and hy3.move_focus("l") or raw_dispatch("hy3:movefocus l"))
hl.bind(mainMod .. " + L", hy3 ~= nil and hy3.move_focus("r") or raw_dispatch("hy3:movefocus r"))
hl.bind(mainMod .. " + K", hy3 ~= nil and hy3.move_focus("u") or raw_dispatch("hy3:movefocus u"))
hl.bind(mainMod .. " + J", hy3 ~= nil and hy3.move_focus("d") or raw_dispatch("hy3:movefocus d"))

hl.bind(mainMod .. " + SHIFT + H", hy3 ~= nil and hy3.move_window("l", { once = true }) or raw_dispatch("hy3:movewindow l once"))
hl.bind(mainMod .. " + SHIFT + L", hy3 ~= nil and hy3.move_window("r", { once = true }) or raw_dispatch("hy3:movewindow r once"))
hl.bind(mainMod .. " + SHIFT + K", hy3 ~= nil and hy3.move_window("u", { once = true }) or raw_dispatch("hy3:movewindow u once"))
hl.bind(mainMod .. " + SHIFT + J", hy3 ~= nil and hy3.move_window("d", { once = true }) or raw_dispatch("hy3:movewindow d once"))

for i = 1, 10 do
  local key = tostring(i % 10)
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hy3 ~= nil and hy3.move_to_workspace(tostring(i)) or raw_dispatch("hy3:movetoworkspace " .. i))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("Print",         hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" -t png /tmp/screenshot-$(date +%F_%T).png; wl-copy < /tmp/screenshot-$(date +%F_%T).png']]))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[bash -c 'grim /tmp/screenshot-$(date +%F_%T).png; wl-copy < /tmp/screenshot-$(date +%F_%T).png']]))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),            { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("code:191", hl.dsp.workspace.toggle_special("magic"),                         { locked = true })
hl.bind("code:192", hl.dsp.exec_cmd("/home/roberto/.local/bin/pausePiP.sh"),          { locked = true })
hl.bind("code:196", hl.dsp.exec_cmd("/home/roberto/dotfiles/polybar/mic-control-toggle.sh"), { locked = true })

hl.bind("code:197", hl.dsp.exec_cmd("/home/roberto/.config/polybar/music-player.sh previous"),   { locked = true })
hl.bind("code:198", hl.dsp.exec_cmd("/home/roberto/.config/polybar/music-player.sh play-pause"), { locked = true })
hl.bind("code:199", hl.dsp.exec_cmd("/home/roberto/.config/polybar/music-player.sh next"),       { locked = true })

hl.bind("code:200", hl.dsp.exec_cmd("/home/roberto/dotfiles/polybar/mic-control-toggle.sh"), { locked = true })
hl.bind("code:200", hl.dsp.exec_cmd("/home/roberto/dotfiles/polybar/mic-control-toggle.sh"), { locked = true })
hl.bind("code:201", hl.dsp.exec_cmd("/home/roberto/dotfiles/polybar/mic-control-toggle.sh"), { locked = true })

hl.bind(mainMod .. " + X", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
  hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }),  { repeating = true })
  hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }),  { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind(mainMod .. " + X", hl.dsp.submap("reset"))
end)

-- kept for parity with old config
local _ = fileManager
