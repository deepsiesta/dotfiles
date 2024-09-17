{ lib, config, pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
      "DP-3, 2560x1440@144, 0x0, 1"
      "DP-1, 2560x1440@144, 2560x0, 1"
      ];
      "$mod" = "Super";
      bind = [
        # Essentials
        "$mod, T, exec, kitty"
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
    };
  };
}
