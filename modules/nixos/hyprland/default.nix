{ flake.modules.nixos.hyprland = { pkgs, ... }: {
  programs.uwsm = {
    enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;

  security.pam.services.hyprlock = {};

  environment.systemPackages = with pkgs; [
    pwvucontrol
    hyprpicker
    hyprshot
    wl-clipboard
    waybar
    networkmanagerapplet
    fuzzel
  ];
}; }
