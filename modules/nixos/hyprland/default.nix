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
  programs.thunar.plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.systemPackages = with pkgs; [
    pwvucontrol
    hyprpicker
    hyprshot
    wl-clipboard
    kitty
    waybar
    networkmanagerapplet
    bitwarden-desktop
    fuzzel
    qimgv
    thud
    xarchiver
    discord
    mpv
    syncplay
    gimp3
    (lutris.override {extraPkgs = pkgs: [winetricks];})
    (bottles.override {removeWarningPopup = true;})
    spotify
    qbittorrent
    insync
    kdePackages.okular
    obsidian
    komikku
    vscode-fhs
  ];

  # Tell Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
