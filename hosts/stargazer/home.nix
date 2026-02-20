{ flake.modules.homeManager.stargazer = { lib, inputs, ... }: {
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = [];

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
      monitor = [
        "HDMI-A-1, 3840x2160@60, -1920x0, 2"
        "DP-1, 2560x1440@144, 0x0, 1"
      ];
      workspace =
        [
          "special:scratchpad, name:scratchpad, monitor:DP-1"
        ]
        ++ (
          # Bind odd workspaces to left screen, even workspaces to right screen
          builtins.concatLists (builtins.genList (
              i: let
                wleft = 2 * i + 1;
                wright = 2 * i + 2;
              in [
                "${toString wleft}, monitor:HDMI-A-1"
                "${toString wright}, monitor:DP-1"
              ]
            )
            5) # Applies rules to workspaces 1 .. 10
        );
      exec-once = [
        "uwsm app -- ckb-next --background"
        "uwsm app -- solaar --window hide"
        "uwsm app -- steam -silent"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}; }
