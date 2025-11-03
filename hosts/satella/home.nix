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
    ../../modules/home-manager/stylix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {};

  wayland.windowManager.hyprland = {
    settings = {
      bindel = [
        " , XF86MonBrightnessUp, exec, light -A 10"
        " , XF86MonBrightnessDown, exec, light -U 10"
      ];
    };
  };
  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = lib.mkForce ["tray" "wireplumber" "battery" "clock"];
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
