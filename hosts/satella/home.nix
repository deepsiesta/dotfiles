{ flake.modules.homeManager.satella = { lib, inputs, ... }: {
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
    inputs.self.modules.homeManager.common
    inputs.self.modules.homeManager.gui
    inputs.self.modules.homeManager.hyprland
    inputs.self.modules.homeManager.waybar
    inputs.self.modules.homeManager.fuzzel
    inputs.self.modules.homeManager.starship
    inputs.self.modules.homeManager.tmux
    inputs.self.modules.homeManager.nushell
    inputs.self.modules.homeManager.fastfetch
    inputs.self.modules.homeManager.stylix
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
}; }
