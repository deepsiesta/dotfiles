{
  pkgs,
  inputs,
  ...
}: {
  # Install firefox.
  programs.firefox.enable = true;

  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [thunar-archive-plugin thunar-volman];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable Obsidian plugin for Neovim
  # programs.nixvim.plugins.obsidian.enable = lib.mkForce true;

  environment.systemPackages = with pkgs; [
    kitty
    bitwarden-desktop
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
    vscodium-fhs
    antigravity-fhs
    code-cursor-fhs
    cursor-cli
  ];
}
