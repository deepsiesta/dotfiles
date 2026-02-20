{ flake.modules.homeManager.waybar = {
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        # output = [ "DP-1" ];

        modules-left = ["hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "wireplumber" "clock"];

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

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };

        "wireplumber" = {
          format = "{icon}";
          tooltip-format = "{node_name}\n{volume}%";
          format-muted = "";
          on-click = "pwvucontrol";
          scroll-step = 2;
          format-icons = ["" "" ""];
        };

        "battery" = {
          interval = 60;
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
          max-length = 25;
        };

        "clock" = {
          interval = 60;
          format = "{:%a %d/%m %H:%M}";
        };
      };
    };
    style = builtins.readFile ./waybar.css;
  };

  # XEmbed compatibility (for Wine tray icons)
  services.xembed-sni-proxy.enable = true;
}; }
