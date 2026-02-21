{
  flake.modules.nixos.stargazer = {
    config,
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      ./hardware-configuration.nix
      inputs.self.modules.nixos.common
      inputs.self.modules.nixos.audio
      inputs.self.modules.nixos.fonts
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.gui
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.stylix
      inputs.self.modules.nixos.gaming
      inputs.self.modules.nixos.obs
      inputs.self.modules.nixos.aagl
      inputs.self.modules.nixos.podman
      inputs.self.modules.nixos.nvidia
      inputs.self.modules.nixos.cuda
      inputs.home-manager.nixosModules.default
      inputs.self.modules.nixos.neovim
    ];

    # Kernel
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    hardware.cpu.intel.updateMicrocode = true;

    # Enable firmware updates
    services.fwupd.enable = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = "stargazer"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Logitech wireless support/configuration
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # Corsair keyboard etc. support
    hardware.ckb-next.enable = true;

    # Xbox Controller
    hardware.xone.enable = true;

    # Enable OpenGL
    hardware.graphics.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    home-manager = {
      # Pass inputs to home-manager modules
      extraSpecialArgs = {inherit inputs;};
      users = {
        "siesta" = inputs.self.modules.homeManager.stargazer;
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };

  flake.modules.homeManager.stargazer = {
    lib,
    inputs,
    ...
  }: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "siesta";
    home.homeDirectory = "/home/siesta";

    home.stateVersion = "24.05"; # PDo not change this

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
  };
}
