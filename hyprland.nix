{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "QT_QPA_PLATFORM, wayland"
        "QT_QPA_PLATFORMTHEME, qt5ct"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
      monitor = [
      "DP-3, 2560x1440@144, 0x0, 1"
      "DP-1, 2560x1440@144, 2560x0, 1"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 8;
        gaps_workspaces = 50;
        border_size = 1;
        "col.active_border" = "0xFF30C0F0";
        no_focus_fallback = true;
        allow_tearing = true;
      };
      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 2;
      };
      animations = {
        enabled = true;
       animation = [
          "specialWorkspace, 1, 3, default, slidefadevert -80%"
        ];
      };
      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
        special_scale_factor = 0.95;
      };
      workspace = [
        "special:scratchpad, name:scratchpad, monitor:DP-1"
      ]
      ++ (
        # Bind odd workspaces to left screen, even workspaces to right screen
        builtins.concatLists (builtins.genList (i:
            let 
              wleft = 2 * i + 1;
              wright = 2 * i + 2;
            in [
              "${toString wleft}, monitor:DP-3"
              "${toString wright}, monitor:DP-1"
            ]
          )
          5) # Applies rules to workspaces 1 .. 10
      );
      # Keybinds
      "$mod" = "Super";
      bind = [
        # Essentials
        "$mod, T, exec, kitty"
        # "$mod, E, exec, dolphin --new-window"
        "$mod, E, exec, thunar"
        "$mod, W, exec, firefox"
        # Move focus
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"
        # Window arrangement
        "$mod+Shift, Left, movewindow, l"
        "$mod+Shift, Right, movewindow, r"
        "$mod+Shift, Up, movewindow, u"
        "$mod+Shift, Down, movewindow, d"
        # Toggle fullscreen
        "$mod, F, fullscreen, 0"
        # Toggle floating
        "$mod+Alt, Space, togglefloating,"
        # Special workspace
        "$mod, grave, togglespecialworkspace, scratchpad"
        # Kill active window
        "$mod, Q, killactive"
        # Kill window clicked on (xkill equivalent)
        "$mod+Shift, Q, exec, hyprctl kill"
        # Screen capture (window)
        "$mod, S, exec, hyprshot --freeze -m window -o \~\/Pictures\/Screenshots"
        # Screen capture (rectangle select)
        "$mod+Shift, S, exec, hyprshot --freeze -m region -o \~\/Pictures\/Screenshots"
        # Screen lock
        "$mod, L, exec, pidof hyprlock || hyprlock"
      ]
      ++ (
        # Workspace navigation
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod ALT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          10)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        ];
      bindr = [
        "$mod, SUPER_L, exec, pkill wofi || wofi --show drun"
      ];
      # Media control
      bindel = [
        " , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
          " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          " , XF86AudioPlay, exec, playerctl play-pause"
          " , XF86AudioPrev, exec, playerctl previous"
          " , XF86AudioNext, exec, playerctl next"
      ];
      exec-once = [
        "swww-daemon --format xrgb"
        "waybar &"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "steam -silent"
        "discord"
        "[workspace special:scratchpad silent] kitty"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background.color = "rgb(0, 0, 0)";
      input-field = [
              {
                monitor = "";
                size = "250, 60";
                outline_thickness = 2;
                dots_size = 0.2;
                dots_spacing = 0.2;
                dots_center = true;
                outer_color = "rgba(255, 255, 255, 0.8)";
                inner_color = "rgb(0, 0, 0)";
                font_color = "rgb(200, 200, 200)";
                fade_on_empty = false;
                position = "0, -120";
                halign = "center";
                valign = "center";
              }
            ];
    };
  };
}
