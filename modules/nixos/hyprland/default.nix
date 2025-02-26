{
  pkgs,
  inputs,
  ...
}: {
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

  # Install firefox.
  programs.firefox.enable = true;

  # Thunar
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.systemPackages = with pkgs; [
    pwvucontrol
    hyprpicker
    hyprshot
    wl-clipboard
    kitty
    inputs.ghostty.packages.x86_64-linux.default
    waybar
    networkmanagerapplet
    bitwarden-desktop
    fuzzel
    qimgv
    discord
    mpv
    syncplay
    # gimp
    (lutris.override {extraPkgs = pkgs: [winetricks];})
    bottles
    spotify
    qbittorrent
    insync
    kdePackages.okular
  ];

  # Tell Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
