{ flake.modules.homeManager.kanami = { lib, inputs, ... }: {
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

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1, 2560x1440@144, 0x0, 1"
      ];
      input = {
        numlock_by_default = lib.mkForce false;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}; }
