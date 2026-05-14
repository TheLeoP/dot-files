hl.monitor {
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
}

hl.on("hyprland.start", function()
  hl.exec_cmd "nm-applet"
  hl.exec_cmd "waybar"
  hl.exec_cmd "systemctl --user start hyprpolkitagent"
  hl.exec_cmd "swaybg --image ~/Pictures/bg.png --mode fill"
  hl.exec_cmd "~/.local/bin/join-desktop"
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config {
  general = {
    gaps_in = 2,
    gaps_out = 5,

    border_size = 2,

    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    rounding_power = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = { enabled = false },
    blur = { enabled = false },
  },
  animations = { enabled = false },
}

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
hl.workspace_rule { workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 }
hl.workspace_rule { workspace = "f[1]", gaps_out = 0, gaps_in = 0 }
hl.window_rule {
  name = "no-gaps-wtv1",
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
}
hl.window_rule {
  name = "no-gaps-f1",
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
}

hl.config {
  dwindle = {
    preserve_split = true, -- You probably want this
  },
}
hl.config {
  master = {
    new_status = "master",
  },
}
hl.config {
  scrolling = {
    fullscreen_on_one_column = true,
  },
}

hl.config {
  misc = {
    disable_hyprland_logo = true,
  },
}

hl.config {
  input = {
    kb_layout = "latam",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = true,
    },
  },
}

hl.gesture {
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
}

local terminal = "wezterm"
local file_manager = "nautilus"
local menu = "hyprlauncher"

local main_mod = "SUPER"

hl.bind(main_mod .. " + delete", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + e", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + d", hl.dsp.exec_cmd(menu))

hl.bind(main_mod .. " + q", hl.dsp.window.close())
hl.bind(main_mod .. " + v", hl.dsp.window.float { action = "toggle" })
hl.bind(main_mod .. " + f", hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" })
hl.bind(main_mod .. " + s", hl.dsp.layout "togglesplit")

hl.bind(main_mod .. " + h", hl.dsp.focus { direction = "left" })
hl.bind(main_mod .. " + j", hl.dsp.focus { direction = "down" })
hl.bind(main_mod .. " + k", hl.dsp.focus { direction = "up" })
hl.bind(main_mod .. " + l", hl.dsp.focus { direction = "right" })
hl.bind(main_mod .. " + SHIFT + h", hl.dsp.window.move { direction = "left", group_aware = true })
hl.bind(main_mod .. " + SHIFT + j", hl.dsp.window.move { direction = "down", group_aware = true })
hl.bind(main_mod .. " + SHIFT + k", hl.dsp.window.move { direction = "up", group_aware = true })
hl.bind(main_mod .. " + SHIFT + l", hl.dsp.window.move { direction = "right", group_aware = true })

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus { workspace = i })
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move { workspace = i, follow = false })
end

hl.bind(main_mod .. " + g", hl.dsp.group.toggle())
-- TODO: join these keymaps with the ones for moving windows if I can
hl.bind(main_mod .. " + left", hl.dsp.group.prev())
hl.bind(main_mod .. " + right", hl.dsp.group.next())

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special "magic")
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move { workspace = "special:magic" })

local media_opts = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", media_opts)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", media_opts)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", media_opts)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", media_opts)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%+", media_opts)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%-", media_opts)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next", { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd "playerctl previous", { locked = true })

hl.bind("print", hl.dsp.exec_cmd "flameshot screen --clipboard")
hl.bind(main_mod .. " + print", hl.dsp.exec_cmd "flameshot gui --accept-on-select --clipboard")

-- join
hl.bind(main_mod .. " + CONTROL + v", hl.dsp.global "desktop:205FD0D140220BD287CCD2FC7F748FA1-Ctrl+Command+V")
hl.bind(main_mod .. " + CONTROL + c", hl.dsp.global "desktop:326356BAF1BF42375785D19B6752E320-Ctrl+Command+C")

hl.define_submap("exit: [r]eboot, [l]ogout, [s]hutdown", function()
  hl.bind("r", hl.dsp.exec_cmd "systemctl reboot")
  hl.bind("s", hl.dsp.exec_cmd "systemctl poweroff")
  hl.bind(
    "l",
    hl.dsp.exec_cmd "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
  )

  hl.bind("escape", hl.dsp.submap "reset")
end)
hl.bind(main_mod .. " + x", hl.dsp.submap "exit: [r]eboot, [l]ogout, [s]hutdown")

hl.window_rule {
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
}
hl.window_rule {
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
}
-- Hyprland-run windowrule
hl.window_rule {
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
}

hl.window_rule {
  name = "move-zen",
  match = { class = "zen" },
  workspace = "2 silent",
}
hl.window_rule {
  name = "move-google-chrome",
  match = { class = "google-chrome" },
  workspace = "2 silent",
}
hl.window_rule {
  name = "move-steam",
  match = { class = "steam" },
  workspace = "3 silent",
}
hl.window_rule {
  name = "move-obs",
  match = { class = "obs" },
  workspace = "3 silent",
}
hl.window_rule {
  name = "move-join",
  match = { title = "^Join$" },
  workspace = "4 silent",
}
