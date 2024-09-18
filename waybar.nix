{config, pkgs, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        # output = [ "DP-1" ];

        modules-left = [ "hyprland/window" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "clock" ];

        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          # all-outputs = true;
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "0" = [];
          };
        };

        "tray" ={
          icon-size = 16;
          spacing = 10;
        };

        "clock" = {
          interval = 60;
          format = "{:%a %d/%m %I:%M}";
        };
      };
    };
    style = builtins.readFile ./dotfiles/waybar.css;
  };
}
