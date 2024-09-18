{ lib, config, pkgs, inputs, ... }:
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
        # Kill active window
        "$mod, Q, killactive"
        # Kill window clicked on (xkill equivalent)
        "$mod+Shift, Q, exec, hyprctl kill"
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
          9)
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
        "waybar &"
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];
    };
  };
}
