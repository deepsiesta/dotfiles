{
  flake.modules.nixos.niri = {pkgs, ...}: {
    programs.niri.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.hyprland.enableGnomeKeyring = true;

    security.pam.services.hyprlock = {};

    services.displayManager.defaultSession = "hyprland-uwsm";

    environment.systemPackages = with pkgs; [
      alacritty
      fuzzel
      swaylock
      mako
      swayidle
      xwayland-satellite
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.hyprland = {...}: {
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
  };
}
