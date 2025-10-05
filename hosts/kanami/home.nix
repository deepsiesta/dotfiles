{lib, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "siesta";
  home.homeDirectory = "/home/siesta";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/gui
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/waybar
    ../../modules/home-manager/fuzzel
    ../../modules/home-manager/starship
    ../../modules/home-manager/tmux
    ../../modules/home-manager/nushell
    ../../modules/home-manager/fastfetch
    ../../modules/home-manager/emacs
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1, 2560x1440@144, 0x0, 1"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
