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
        # Toggle fullscreen
        "$mod, F, fullscreen, 0"
        # Toggle floating
        "$mod+Alt, Space, togglefloating,"
        # Kill active window
        "$mod, Q, killactive"
        # Kill window clicked on (xkill equivalent)
        "$mod+Shift, Q, exec, hyprctl kill"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        ];
      bindr = [
        "$mod, SUPER_L, exec, pkill wofi || wofi --show drun"
      ];
      exec-once = [
        "waybar &"
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];
    };
  };
}
